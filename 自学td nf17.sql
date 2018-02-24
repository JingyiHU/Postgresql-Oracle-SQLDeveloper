-- questions



create table CLIENT(
  num number,
  nom varchar(20),
  prenom varchar(20),
  adresse varchar(128),
  date_nais date,
  tel varchar(20),
  sexe char check(sexe in ('m','f')),
  constraint PK_CLIENT primary key(num)
);

create table FACTURE(
  num number,
  date_etabli date,
  client number,
  constraint PK_FACTURE primary key(num),                            -- 该表的主键是num 类型为number
  constraint FK_FACTURE foreign key(client) references CLIENT(num)                 -- 外键 references后面写的是table名 看是哪个表的主键
);


create table PRODUIT(
  num number,
  designation varchar(128),
  prix number,
  stock number,
  constraint PK_PRODUIT primary key(num)
);


create table LIGNE_FACT(
  facture number,
  produit number,
  qte number,   #商品的数目
  constraint PK_LIGNE_FACT primary key(factrue, produit),
  constraint FK_LIGNE_FACT foreign key(facture) references FACTURE(num),
  constraint FK_LIGNE_FACT foreign key(produit) references PRODUIT(num)
);


# Écrivez une requête SQL LMD pour calculer pour chaque produit, le nombre d'articles vendus, trié par ordre décroissant.降序排列卖出的商品的数量。

SELECT p.nom, p.designation, sum(lf.qte) AS nb  #select出来要用的变量
FROM produit p, ligne_fact lf  #from后面加表的名称
WHERE lf.produit = p.num
GROUP BY p.nom, p.designation  #用groupe by可以确保计算的是一个产品
ORDER BY nb DESC;

# Ecrivez une requête SQL LMD pour calculer les chiffres d'affaire par client, triés par ordre décroissant. 降序排列每个顾客的消费额。

# 每个顾客的消费额等于 消费每个产品数目乘以对应的价格 

select c.nom, c.prenom, c.num, sum(lf.qte * p.prix) as affiare               #要用的都列出来
from produit p, client c, facture f, ligne_fact lf
where c.num = f.client 
and f.num = lf.facture 
and p.num = lf.produit
groupe by c.num, c.nom, c.prenom
order by affaire desc


# Ecrivez une requête SQL LMD pour calculer le montant moyen des factures pour chaque client, trié par ordre croissant.

select client, avg(montant) moy
from(
select c.num as client, f.num, sum(lf.qte*p.prix) as montant
from client c, produit p, facture f, ligne_fact lf
where c.num = f.client
and p.num = lf.produit
and  f.num = lf.facture
groupe by c.num, f.num
)
groupe by client
order by moy;

# Écrivez deux requêtes SQL LMD pour obtenir la liste des produits dont le prix est maximal et dont le prix est minimal.

select distinct designation "prix max"
from produit
where prix in (select max(prix) from produit);

select disdinct designation "prix min"
from produit 
where prix in (select min(prix) from produit);


#Écrivez la requête SQL LMD qui permet de renvoyer la liste des clients (num, nom et prénom) avec leur chiffre d'affaire et leur catégorie (VIP, Ordinaire ou Potentiel)


select c.num, c.nom, c.prenom, sum(lf.qte * p.prix) as chiffre_affaire
	case
		when chiffre_affaire > 500 then 'vip'
		when chiffre_affaire between 50 and 500 then 'ordinaire'
	else 'potentiel'
	end categorie
from client c, facture f, ligne_fact lf, produit p
where p.num = lf.produit
and f.num = lf.facture
and c.num = f.client
group by c.num, c.nom, c.prenom;

#Écrivez la requête SQL LDD qui crée la vue "Chiffre_Affaire" permettant de répondre au besoin des opérateurs du service après vente.


create view v_chiffire_affaire as
select c.num, c.nom, c.prenom, sum(lf.qte * p.prix) as chiffre_affaire
	case
		when chiffre_affaire > 500 then 'vip'
		when chiffre_affaire between 50 and 500 then 'ordinaire'
	else 'potential'
	end categorie
from client c, facture f, ligne_fact lf, produit p
where c.num = f.client
and f.num = lf.facture
and p.num = lf.produit
group by c.num, c.nom, c.prenom;

# Écrire la requête SQL LMD qui renvoie la catégorie du client 1.

select categorie from v_chiffre_affaire where num = 1;




