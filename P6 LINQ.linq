<Query Kind="Statements">
  <Connection>
    <ID>efda33bd-f477-4aae-9a24-9e2559fd3b10</ID>
    <NamingServiceVersion>2</NamingServiceVersion>
    <Persist>true</Persist>
    <Server>localhost\MSSQLSERVER01</Server>
    <AllowDateOnlyTimeOnly>true</AllowDateOnlyTimeOnly>
    <Database>P6_Dotnet</Database>
    <DriverData>
      <LegacyMFA>false</LegacyMFA>
    </DriverData>
  </Connection>
</Query>

Console.WriteLine("Veuillez entrer le statut (ou appuyez sur Entrée pour ignorer) :");
string statut = Util.ReadLine();

Console.WriteLine("Veuillez entrer le nom du produit (ou appuyez sur Entrée pour ignorer) :");
string produit = Util.ReadLine();

Console.WriteLine("Veuillez entrer la version (ou appuyez sur Entrée pour ignorer) :");
string version = Util.ReadLine();

Console.WriteLine("Veuillez entrer la date de début (ou appuyez sur Entrée pour ignorer) :");
string dateDebutInput = Util.ReadLine();
DateOnly? dateDebut = string.IsNullOrEmpty(dateDebutInput) ? (DateOnly?)null : DateOnly.Parse(dateDebutInput);

Console.WriteLine("Veuillez entrer la date de fin (ou appuyez sur Entrée pour ignorer) :");
string dateFinInput = Util.ReadLine();
DateOnly? dateFin = string.IsNullOrEmpty(dateFinInput) ? (DateOnly?)null : DateOnly.Parse(dateFinInput);

Console.WriteLine("Veuillez entrer les mots-clés, séparés par des virgules (ou appuyez sur Entrée pour ignorer) :");
string motsClesInput = Util.ReadLine();
List<string> motsCles = string.IsNullOrEmpty(motsClesInput) ? null : motsClesInput.Split(',').ToList();

// 1, 6, 11, 16
// récupère tous les problèmes pour tous les produits qui correspondent à un certain statut et contiennent certains mots-clés.
var problemesTousProduit = this.Problemes
	.Where(p => p.Statut == statut)
	.AsEnumerable()
    .Where(p => motsCles == null ? true : motsCles.Any(motCle => p.Description.Contains(motCle)));


// 2, 3, 12, 13
// récupère tous les problèmes pour un produit spécifique et une version spécifique qui correspondent à un certain statut.
var problemesProduit = this.Problemes
	.Where(p => p.Produit.Nom == produit)
	.Where(p => p.Statut == statut)
	.Where(p => string.IsNullOrEmpty(version) || p.Version.Numero_version == version);

// 4, 5, 9, 10
// récupère tous les problèmes pour un produit spécifique qui ont été signalés pendant une certaine période et contiennent certains mots-clés.
// param optionnel : mots clés, version
var problemesRencontresPeriode = this.Problemes
	.Where(p => p.Produit.Nom == produit)
	.Where(p => p.Date_signalement >= dateDebut.GetValueOrDefault() && p.Date_signalement <= dateFin.GetValueOrDefault(DateOnly.MaxValue))
	.Where(p => string.IsNullOrEmpty(version) || p.Version.Numero_version == version)
	.AsEnumerable()
    .Where(p => motsCles == null ? true : motsCles.Any(motCle => p.Description.Contains(motCle)));

// 7, 8
// récupère tous les problèmes en cours pour un produit spécifique et une version spécifique qui ont été signalés pendant une certaine période et contiennent certains mots-clés.
// param : produit, version, date début, date fin
// param optionnel : mots clés, version
var problemesEnCoursPeriode = this.Problemes
	.Where(p => p.Statut == "En cours")
	.Where(p => p.Produit.Nom == produit)
	.Where(p => p.Date_signalement >= dateDebut.GetValueOrDefault() && p.Date_signalement <= dateFin.GetValueOrDefault(DateOnly.MaxValue))
    .Where(p => string.IsNullOrEmpty(version) || p.Version.Numero_version == version)
	.AsEnumerable()
	.Where(p => motsCles == null ? true : motsCles.Any(motCle => p.Description.Contains(motCle)));

// 14, 15, !!!!!17, !!!!!!!18, 19, 20
// récupère tous les problèmes pour un produit spécifique et une version spécifique qui ont été résolus pendant une certaine période et contiennent certains mots-clés.
// param : produit, version, date début, date fin
// param optionnel : mots clés, version
var problemesResolusPeriode = this.Problemes
	.Where(p => p.Statut == "Résolu")
	.Where(p => p.Produit.Nom == produit)
	.Where(p => p.Resolutions.Any(r => r.Date_resolution >= dateDebut.GetValueOrDefault() && r.Date_resolution <= dateFin.GetValueOrDefault(DateOnly.MaxValue)))
    .Where(p => string.IsNullOrEmpty(version) || p.Version.Numero_version == version)
	.AsEnumerable()
	.Where(p => motsCles == null ? true : motsCles.Any(motCle => p.Description.Contains(motCle)));

var result = problemesResolusPeriode.ToList();
result.Dump();

// V 2.0 présentée 10/06 !!!!!!!!!!! Trois requêtes

/* 
// Requête pour obtenir tous les problèmes rencontrés pour un produit au cours d'une période
// Paramètres : produit, dateDebut, dateFin, version (optionnel), mots-clés (optionnels)
// 4, 5, 9, 10
var problemesProduitParPeriodeQuery = this.Problemes
	.Where(p => p.Produit.Nom == produit)
	.Where(p => string.IsNullOrEmpty(version) || p.Version.Numero_version == version)
	.Where(p => p.Date_signalement >= dateDebut.GetValueOrDefault())
    .Where(p => p.Date_signalement <= dateFin.GetValueOrDefault(DateOnly.MaxValue))
	.AsEnumerable()
    .Where(p => motsCles == null ? true : motsCles.Any(motCle => p.Description.Contains(motCle)));

// Requête pour obtenir tous les problèmes en cours
// Paramètres : produit, statut, version (optionnel), dateDebut (optionnel), dateFin (optionnel), mots-clés (optionnels)
// 1, 2, 3, 6, 7, 8
var problemesEnCoursQuery = this.Problemes
	.Where(p => p.Statut == "En cours")
	.Where(p => string.IsNullOrEmpty(produit) || p.Produit.Nom == produit)
	.Where(p => string.IsNullOrEmpty(version) || p.Version.Numero_version == version)
	.Where(p => dateDebut == null || p.Date_signalement >= dateDebut.GetValueOrDefault())
    .Where(p => dateFin == null || p.Date_signalement <= dateFin.GetValueOrDefault(DateOnly.MaxValue))
	.AsEnumerable()
    .Where(p => motsCles == null ? true : motsCles.Any(motCle => p.Description.Contains(motCle)));

// Requête pour obtenir tous les problèmes résolus
// Paramètres : produit, statut, version (optionnel), dateDebut (optionnel), dateFin (optionnel), mots-clés (optionnels)
// 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
var problemesResolusQuery = this.Problemes
	.Where(p => p.Statut == "Résolu")
	.Where(p => string.IsNullOrEmpty(produit) || p.Produit.Nom == produit)
	.Where(p => string.IsNullOrEmpty(version) || p.Version.Numero_version == version)
	.Where(p => dateDebut == null || p.Date_signalement >= dateDebut.GetValueOrDefault())
    .Where(p => dateFin == null || p.Date_signalement <= dateFin.GetValueOrDefault(DateOnly.MaxValue))
	.AsEnumerable()
    .Where(p => motsCles == null ? true : motsCles.Any(motCle => p.Description.Contains(motCle)));
	
var result = problemesResolusQuery.ToList();
result.Dump();
	
/* V 1.0 nulle 
// Requête pour obtenir tous les problèmes sans spécifier de produit.
// Paramètres : statut (optionnel), motsCles (optionnel)
// 1, 6, 11, 16
var problemeQuery = this.Problemes
    .Where(p => string.IsNullOrEmpty(statut) || p.Statut == statut)
    .AsEnumerable()
    .Where(p => motsCles == null ? true : motsCles.Any(motCle => p.Description.Contains(motCle)));

// Requête pour obtenir tous les problèmes d'un produit.
// Paramètres : produit, statut (optionnel), version (optionnel), dateDebut (optionnel), dateFin (optionnel), motsCles (optionnel)
// 2, 4, 5, 7, 9, 10, 12, 17
var problemeParProduitQuery = this.Problemes
    .Where(p => p.Produit.Nom == produit)
	.Where(p => string.IsNullOrEmpty(statut) || p.Statut == statut)
    .Where(p => string.IsNullOrEmpty(version) || p.Version.Numero_version == version)
    .Where(p => dateDebut == null || p.Date_signalement >= dateDebut.GetValueOrDefault())
    .Where(p => dateFin == null || p.Date_signalement <= dateFin.GetValueOrDefault(DateOnly.MaxValue))
    .AsEnumerable()
    .Where(p => motsCles == null ? true : motsCles.Any(motCle => p.Description.Contains(motCle)));

// Requête pour obtenir tous les problèmes d'une version d'un produit.
// Paramètres : produit, version, statut (optionnel), motsCles (optionnel)
// 3, 5, 8, 13, 18
var problemeParVersionQuery = this.Problemes
    .Where(p => p.Produit.Nom == produit && p.Version.Numero_version == version)
    .Where(p => string.IsNullOrEmpty(statut) || p.Statut == statut)
    .AsEnumerable()
    .Where(p => motsCles == null ? true : motsCles.Any(motCle => p.Description.Contains(motCle)));

// Requête pour obtenir tous les problèmes résolus pour un produit spécifique
// Paramètres : produit, version (optionnel), dateDebut, dateFin, motsCles (optionnel)
// 14, 15, 19, 20
var problemeResoluParProduitQuery = this.Problemes
    .Where(p => p.Produit.Nom == produit && p.Statut == "Résolu")
    .Where(p => string.IsNullOrEmpty(version) || p.Version.Numero_version == version)
    .Where(p => p.Resolutions.Any(r => r.Date_resolution >= dateDebut.GetValueOrDefault() && r.Date_resolution <= dateFin.GetValueOrDefault(DateOnly.MaxValue)))
    .AsEnumerable()
    .Where(p => motsCles == null ? true : motsCles.Any(motCle => p.Description.Contains(motCle)));

var result = problemeParProduitQuery.ToList();
result.Dump();

/* 
// Requête pour obtenir tous les problèmes rencontrés au cours d’une période donnée pour un produit spécifique
// Paramètres : produit, version (optionnel), dateDebut, dateFin, motsCles (optionnel)
// 
var problemeEnCoursParProduitQuery = this.Problemes
    .Where(p => p.Produit.Nom == produit && p.Statut == "En cours")
    .Where(p => string.IsNullOrEmpty(version) || p.Version.Numero_version == version)
    .Where(p => p.Resolutions.Any(r => r.Date_resolution >= dateDebut.GetValueOrDefault() && r.Date_resolution <= dateFin.GetValueOrDefault(DateOnly.MaxValue)))
    .AsEnumerable()
    .Where(p => motsCles == null ? true : motsCles.Any(motCle => p.Description.Contains(motCle)));
	
	*/