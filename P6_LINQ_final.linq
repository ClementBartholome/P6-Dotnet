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
// Paramètres : produit (optionnel), version (optionnel), dateDebut (optionnel), dateFin (optionnel), mots-clés (optionnels)
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
// Paramètres : produit (optionnel), version (optionnel), dateDebut (optionnel), dateFin (optionnel), mots-clés (optionnels)
// 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
var problemesResolusQuery = this.Problemes
	.Where(p => p.Statut == "Résolu")
	.Where(p => string.IsNullOrEmpty(produit) || p.Produit.Nom == produit)
	.Where(p => string.IsNullOrEmpty(version) || p.Version.Numero_version == version)
	.Where(p => dateDebut == null || p.Resolutions.Any(r => r.Date_resolution >= dateDebut.GetValueOrDefault()))
    .Where(p => dateFin == null || p.Resolutions.Any(r => r.Date_resolution <= dateFin.GetValueOrDefault(DateOnly.MaxValue)))
	.AsEnumerable()
    .Where(p => motsCles == null ? true : motsCles.Any(motCle => p.Description.Contains(motCle)));
	
var result = problemesResolusQuery.ToList();
result.Dump();

	