-- oracle题目

e1: 
Film(#isan:char(33),titre:varchar2,debut:date,fin:date)

# Écrire une fonction duree permettant de retourner un nombre entier de jours entre deux dates passées en argument.

CREATE FUNCTION duree(debut date, fin date) RETURN integer
IS 
BEGIN
RETURN to_number(to_char(fin, 'j'), '99999999') - to_number(to_char('debut', 'j'), '99999999');
END;

# Créer en SQL une vue vFilm affichant tous les attributs de Film, avec une colonne supplémentaire affichant la durée.

CREATE VIEW vFilm AS
SELECT isan, titre, debut, fin, duree(debut, fin)
FROM film;


e2:
emp (ename, job, hiredate, sal) 
# A partir de la table "emp", afficher le nom des employés ("ename") concaténé avec leur poste ("job") en les séparant par une virgule suivi d'une espace et donner comme titre à la colonne "EMPLOYE ET FONCTION"

select ename||', '||job "MPLOYE ET FONCTION"
from emp;

# Afficher le nom et la date d'embauche ("hiredate") des employés embauchés entre le 20 février 1981, et 1 mai 1981. Classez le résultat par date d'embauche.

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN
	TO_DATE('20-feb-1981', 'DD-MON-YYYY')
	AND TO_DATE('01-may-1981', 'DD-MON-YYYY')
ORDER BY hiredate;

#afficher le nom de tous les employés, dont le nom contient deux fois la lettre "L".

SELECT ename
FROM emp
WHERE ename LIKE '%L%L%';

#Afficher le nom, poste et salaire ("sal') de tous les personnes qui ont comme poste 'Clerk' ou 'Analyst' et dont le salaire est différent de $1000, $3000, ou $5000.

SELECT ename, job, sal 
FROM emp
WHERE job IN ('Clerk' or 'Analyst')
AND sal NOT IN ('1000', '3000', '5000');


#Afficher le nom de chaque employé et calculer le nombre de mois qu'il a travaillé jusqu'à ce jour (après l'avoir arrondi celui-ci à la plus proche valeur entière). Nommer la colonne MONTHS_WORKED.

SELECT ename, ROUND(MONTH_BETWEEN(SYSDATE, hiredate)) MONTHS_WORKED
FROM emp;


#Ecrivez la requête qui affiche pour chaque employé le résultat suivant :

"X" gagne "Y" par mois mais il veut "3 fois Y".

Nommer la colonne SALAIRES DE REVES.

SELECT
 ename || ' gagne '
  || TO_CHAR(sal, 'fm$99,999.00')
  ||' par mois mais il veut '
  || TO_CHAR(sal * 3, 'fm$99,999.00')
  || '.'"SALAIRES DE REVES"
FROM emp;



#Afficher le salaire maximum, minimum, la somme des salaires et le salaire moyen de tous les employés. Nommer les colonnes respectivement Maximum, Minimum, Sum, and Average. Arrondissez les résultats à zéro décimales.

SELECT 
	ROUND(MAX(sal), 0) "Maximum",
	ROUND(MIN(sal), 0) "Minimum",
	ROUND(SUM(sal), 0) "Sum",
	ROUND(AVG(sal), 0) "Average"
FROM emp;