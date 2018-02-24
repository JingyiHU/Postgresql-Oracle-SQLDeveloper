-- insert into client  

#对应每个variable插入一个具体值 每个都用单引号扩起来

insert into CLIENT(num, nom, prenom, adresse, date_nais, tel, sexe) values (
	client_seq.NEXTVAL,  #这里写nextval 下一个值 #对应num
	'coulomb',           #nom
	'francois',          #prenom
	'4, rue liberte',    #adresse
	to_date('02121980','DDMMYYYY'),   #date
	'06456780',         #tel
	'm'                 #sexe
);

insert into CLIENT(num, nom, prenom, adresse, date_nais, tel, sexe) values (
	client_seq.NEXTVAL,
	'bernard',
	'dupont',
	'120, square zola',
	to_date('19081972','DDMMYYYY'),
	'01345678',
	'm'
);

insert into CLIENT(num, nom, prenom, adresse, date_nais, tel, sexe) values (
	client_seq.NEXTVAL,
	'corda',
	'nathalie',
	'66, bv napoleon III',
	to_date('02101977','DDMMYYYY'),
	'06455790',
	'f'
);

insert into CLIENT(num, nom, prenom, adresse, date_nais, tel, sexe) values (
	client_seq.NEXTVAL,
	'pierre',
	'alexandre',
	'1, place des martyres',
	to_date('19081972','DDMMYYYY'),
	'01645870',
	'f'
);

commit;
