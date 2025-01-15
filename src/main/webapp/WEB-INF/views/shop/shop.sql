show tables;

create table categoryMain(
	mainCode  char(1)  			not null,		/* 대분류코드(A,B,C,...) => 영문 대문자 1자(중복불허) */
  mainName 	varchar(30)		not null, 	/* 대분류명(회사명 => 삼성/현대/LG...(중복불허) */
  primary key(mainCode),
  unique key(mainName)
);

create table categoryBase(
	baseCode  char(2)  			not null,			/* 중분류코드(01,02,03,...) => 문자형 숫자 2자(중복불허) */
  baseName  varchar(30)  	not null,			/* 중분류명(제품분류명 => 전자제품/생활가전/차종/의류/신발류...(중복불허) */
  mainName  varchar(30) 	not null, 		/* 대분류명(회사명 => 삼성/현대/LG...(외래키) */
  primary key(baseCode),
  unique key(baseName),
  foreign key(mainName) references categoryMain(mainName)
 );

create table categorySub(
	subCode  	char(2)  			not null,			/* 소분류코드(001,002,003,...) => 문자형 숫자 3자(중복불허) */
  subName	 	varchar(30)  	not null,			/* 소분류명(상품구분 => 중분류가 전자제품이라면? 냉장고/에어컨/오디오/TV */
  baseName  varchar(30)  	not null,			/* 중분류이름를 외래키로 지정 */
  mainName  varchar(30) 	not null, 		/* 대분류이름를 외래키로 지정 */
  primary key(subCode),
  unique key(subName),
  foreign key(mainName) references categoryMain(mainName),
  foreign key(baseName) references categoryBase(baseName)
);

create table product(
  idx  					int						not null auto_increment,/* 상품고유번호 */
  productCode		varchar(50)		not null,								/* 상품고유코드 */
	productName		varchar(50)		not null,								/* 상품명 */
	subName				varchar(30)		not null,								/* 소분류이름*/
	baseName			varchar(30)		not null,								/* 중분류이름*/
	mainName			varchar(30)		not null,								/* 대분류이름 */
	price					int						default 0,							/* 상품가격 */
	discount			int						default 0,							/* 할인율 */				
	pay						int						default 0,							/* 판매금액 */
	thumbnail			varchar(200) 	default 'noimage.jpg',	/* 썸네일 */
	titleImg			varchar(1000)	default 'noimage.jpg',	/* 메인이미지 */
	fName					varchar(200),													/* 파일이름 */
	fSName				varchar(200),													/* 실제파일이름 */
	fSize					int,																	/* 파일크기 */
	content				text,																	/* 상세내용 */
	claim					int						default 0,							/* 신고 */
	interest			int						default 0,							/* 찜 */
	wDate					datetime			default now(),					/* 상품등록일자 */
	status				varchar(30)		default 'OK',						/* 상품판매상태 */
	display				char(3)				default 'ON',						/* 상품등록상태 */
	
	primary key (idx),
	unique key (productCode),
	foreign key(mainName) references categoryMain(mainName),
  foreign key(baseName) references categoryBase(baseName),
  foreign key(subName) references categorySub(subName)
);

create table productOption(
  idx    			int 				not null auto_increment, /* 옵션 고유번호 */
  optionName	varchar(30)	not null,					/* 옵션이름 */
	productIdx	int					not null,						/* product테이블(상품)의 고유번호 - 외래키로 지정 */
	price				int					not null	default 0,		/* 옵션가격 */
	quantity		int					not null	default 0,		/* 옵션수량 */

  primary key(idx),
  foreign key(productIdx) references product(idx)
);

ALTER TABLE product AUTO_INCREMENT = 1;


create table products(
  idx  					int						not null auto_increment,/* 상품고유번호 */
  productCode		varchar(50)		not null,								/* 상품고유코드 */
	productName		varchar(50)		not null,								/* 상품명 */
	subName				varchar(30)		not null,								/* 소분류이름*/
	baseName			varchar(30)		not null,								/* 중분류이름*/
	mainName			varchar(30)		not null,								/* 대분류이름 */
	price					int						default 0,							/* 상품가격 */
	discount			int						default 0,							/* 할인율 */				
	pay						int						default 0,							/* 판매금액 */
	thumbnail			varchar(200) 	default 'noimage.jpg',	/* 썸네일 */
	titleImg			varchar(1000)	default 'noimage.jpg',	/* 메인이미지 */
	fName					varchar(200),													/* 파일이름 */
	fSName				varchar(200),													/* 실제파일이름 */
	fSize					int,																	/* 파일크기 */
	content				text,																	/* 상세내용 */
	claim					int						default 0,							/* 신고 */
	interest			int						default 0,							/* 찜 */
	wDate					datetime			default now(),					/* 상품등록일자 */
	status				varchar(30)		default 'OK',						/* 상품판매상태 */
	display				char(3)				default 'ON',						/* 상품등록상태 */
	
	primary key (idx),
	unique key (productCode),
	foreign key(mainName) references categoryMain(mainName),
  foreign key(baseName) references categoryBase(baseName)
);




