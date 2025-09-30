-- 1. Afficher la liste des noms des focaccias par ordre alphabétique croissant
SELECT nom 
FROM foccacia
ORDER BY nom ASC;

-- Résultat attendu : Liste de mes 8 foccacias
-- Résultat obtenu : Les 8 foccacias apparaissent dans ma zone SQL. 

-- 2. Afficher le nombre total d'ingrédients
SELECT COUNT(*) AS nb_ingredients 
FROM ingredient;

-- Résultat attendu : Affichier le nombre total de mes ingrédient sois 25
-- Résultat obtenu : Le nombre 25 ressort donc j'ai bien tous mes ingrédients.

-- 3. Afficher le prix moyen des focaccias
SELECT ROUND(AVG(prix), 2) AS prix_moyen 
FROM foccacia;

--Résultat attendu : Prix moyen de l'ensemble de 8 foccacias présent ( sois 10,375 environs)
--Résultat obtenu : J'ai obtenu 10,38 de prix moyen des foccacia
--Commentaire : 1 cts de plus du a l'arrondi.

-- 4 Afficher la liste des boissons avec leur marque, triée par nom de boisson
SELECT b.nom AS boisson, m.nom AS marque
FROM boisson b
JOIN marque m ON b.id_marque = m.id_marque
ORDER BY b.nom ASC;

-- Résultat attendu : Affiche le noms des boissons et de leur marque triée par le nom de boisson
-- Résultat obtenu : Les boissons apparaisent toutes dans l'orde suivant : 
-- "Capri-sun : Coca-cola
--Coca-cola original : Coca-cola
--Coca-cola zéro : Coca-cola
--Eau de source : Cristalinne
--Fanta citron : Coca-cola
--Fanta orange : Coca-cola
--Lipton Peach : Pepsico
--Lipton zéro citron : Pepsico
--Monster energy ultra blue : Monster
--Monster energy ultra gold : Monster
--Pepsi : Pepsico
--Pepsi Max Zéro : Pepsico

-- 5. Afficher la liste des ingrédients pour une Raclaccia
SELECT i.nom
FROM foccacia f
JOIN foccacia_ingredient fi ON f.id_foccacia = fi.id_foccacia
JOIN ingredient i ON fi.id_ingredient = i.id_ingredient
WHERE f.nom = 'Raclaccia';

-- Résultat attendu : Afficher tous les ingredients necessaire pour la Raclaccia (7 ingrédients)
-- Résultat obtenu : J'ai bien mes 7 ingrédients.

-- 6. Afficher le nom et le nombre d'ingrédients pour chaque foccacia
SELECT f.nom, COUNT(fi.id_ingredient) AS nb_ingredients
FROM foccacia f
JOIN foccacia_ingredient fi ON f.id_foccacia = fi.id_foccacia
GROUP BY f.id_foccacia, f.nom;

-- Résultat attendu : Un petit tableau avec : une foccacia (son nom) suivis du nombre d'ingrédients pour celle-ci.
-- Résultat obtenu : Mes 8 foccacias apparaissent bien avec la quantité d'ingrédent.

-- 7. Afficher le nom de la focaccia qui a le plus d'ingrédients
SELECT f.nom, COUNT(fi.id_ingredient) AS nb_ingredients
FROM foccacia f
JOIN foccacia_ingredient fi ON f.id_foccacia = fi.id_foccacia
GROUP BY f.id_foccacia, f.nom
ORDER BY nb_ingredients DESC
LIMIT 1;

-- Résultat attendu : Je doit voir apparaître la foccacia "Paysanne" qui contient le plus d'ingrédients.
-- Résultat obtenu : J'ai bien la foccacia "Paysanne" qui ressort avec 12 ingrédients.

-- 8 Afficher la liste des focaccia qui contiennent de l'ail,
SELECT DISTINCT f.nom
FROM foccacia f
JOIN foccacia_ingredient fi ON f.id_foccacia = fi.id_foccacia
JOIN ingredient i ON fi.id_ingredient = i.id_ingredient
WHERE i.nom = 'Ail';

-- Résultat attendu : Je doit voir les foccacias suivante : Mozaccia, Gorgonzollaccia, Raclaccia, Paysanne
-- Résultat obtenu : J'ai bien les 4 foccacias qui ressortent.

-- 9. Afficher la liste des ingrédients inutilisés
SELECT i.nom
FROM ingredient i
LEFT JOIN foccacia_ingredient fi ON i.id_ingredient = fi.id_ingredient
WHERE fi.id_ingredient IS NULL;

-- Résultat attendu : J'ai deux ingrédient jamais utilisé (Salami et Tomate cerise) qui doivent apparaitre
-- Résultat obtenu : J'ai bien mes deux ingrédient qui apparaissent.

-- 10. Afficher la liste des focaccia qui n'ont pas de champignons.
SELECT f.nom
FROM foccacia f
WHERE f.id_foccacia NOT IN (
    SELECT fi.id_foccacia
    FROM foccacia_ingredient fi
    JOIN ingredient i ON fi.id_ingredient = i.id_ingredient
    WHERE i.nom = 'Champignon'
);

-- Résultat attendu : Deux foccacias n'ont pas de champignon et devrons donc apparaitre (Américaine et Hawaienne)
-- Résultat obtenu : Les deux foccacias apparaissent bien.