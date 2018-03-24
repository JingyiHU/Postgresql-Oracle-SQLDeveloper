--creation de la base oracle

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

create sequence cilent_seq
INCREMENT BY 1
START WITH 1
NOMAXVALIUE
NOCYCLE
CACHE 10;

create table FACTURE(
  num number,
  date_etabli date,
  client number,
  constraint PK_FACTURE primary key(num), -- 该表的主键是num 类型为number
  constraint FK_FACTURE foreign key(client) references CLIENT(num)   -- 外键 references后面写的是table名 看是哪个表的主键
);


create sequence facture_seq
INCREMENT BY 1 
START WITH 1
NOMAXVALUE
NOCYCLE
CACHE 10;

create table PRODUIT(
  num number,
  designation varchar(128),
  prix number,
  stock number,
  constraint PK_PRODUIT primary key(num), 
);

create sequence produit_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
CACHE 10;

create table LIGNE_FACT(
  facture number,
  produit number,
  qte number,
  constraint PK_LIGNE_FACT primary key(factrue, produit),
  constraint FK_LIGNE_FACT foreign key(facture) references FACTURE(num),
  constraint FK_LIGNE_FACT foreign key(produit) references PRODUIT(num)
);

# 这是一个连接表 连接facture 和 produit这两个表
# 一个顾客可以有很多facture 所以一个facture这个表里就不清楚有多少顾客 所以要加一个“顾客”这个表做外键
# 一个商品可能出现在很多facture里 一个facture里也可能有许多商品 所以用这样一个中间连接的表 把它们联系起来 

