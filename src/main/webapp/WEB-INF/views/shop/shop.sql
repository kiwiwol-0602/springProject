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

/* =========================== 상품 주문시에 사용되는 테이블(장바구니 / 주문 / 배송 / 이벤트 / 쿠폰 )===============================*/

/* 장바구니 테이블 */
create table productCart (
  idx   int not null auto_increment,
  mid		varchar(20) not null,						/* 장바구니를 사용한 사용자의 아이디 - 로그인한 회원 아이디 */
  productIdx 	int not null,							/* 장바구니에 담은 상품의 고유번호 */
  productName varchar(50) not null,			/* 장바구니에 담은 상품명 */
  price		int not null,									/* 메인상품의 기본 가격 */
  thumbnail		varchar(100) not null,		/* 서버에 저장된 상품의 메인 이미지 */
  optionIdx		varchar(50)  not null,		/* 옵션의 고유번호 리스트(여러개가 될수 있기에 문자열 배열로 처리한다.) */
  optionName	varchar(100)  not null,		/* 옵션명 리스트(여러개가 될수 있기에 문자열 배열로 처리한다.) */
  optionPrice	varchar(100)  not null,		/* 옵션가격 리스트(여러개가 될수 있기에 문자열 배열로 처리한다.) */
  optionNum		varchar(50)  not null,		/* 옵션수량 리스트(여러개가 될수 있기에 문자열 배열로 처리한다.) */
  totalPrice	int not null,							/* 구매한 모든 항목(상품+옵션)에 따른 총 가격 */  
  cartDate datetime default now() not null,	/* 장바구니에 상품을 담은 날짜 */
  primary key(idx),
  foreign key(mid) references member(mid) on update cascade on delete cascade
);
desc dbCart;

/* 주문 테이블 */
create table productOrder (
  idx   int not null auto_increment,
  orderIdx  varchar(15) not null,				/* 주문 고유번호(새로 만들어준다) */
  mid		varchar(30) not null,						/* 주문한 사용자의 아이디 - 로그인한 회원 아이디 */
  productIdx 	int not null,							/* 주문한 상품의 고유번호 */
  productName varchar(50) not null,			/* 주문한 상품명 */
  mainPrice		int not null,							/* 메인상품의 기본 가격 */
  thumbnail		varchar(100) not null,		/* 서버에 저장된 상품의 메인 이미지 */
  optionName	varchar(100)  not null,		/* 옵션명 리스트(여러개가 될수 있기에 문자열 배열로 처리한다.) */
  optionPrice	varchar(100)  not null,		/* 옵션가격 리스트(여러개가 될수 있기에 문자열 배열로 처리한다.) */
  optionNum		varchar(50)  not null,		/* 옵션수량 리스트(여러개가 될수 있기에 문자열 배열로 처리한다.) */
  totalPrice	int not null,							/* 구매한 모든 항목(상품+옵션)에 따른 총 가격 */  
  orderDate   datetime default now() not null, /* 실제 주문한 날짜 */
  primary key(idx),
  foreign key(mid) references users(mid) on update cascade on delete cascade,
  foreign key(productIdx) references product(idx) on update cascade on delete restrict
);

/* 쿠폰 테이블 */
create table coupons (
    idx int not null auto_increment,
    couponCode varchar(50) not null,          /* 쿠폰 코드 */
    couponName varchar(50) not null,              /* 쿠폰명 */
    discountType enum('percent', 'amount') not null,  /* 할인 유형 (퍼센트 or 금액) */
    discount decimal(10, 2) not null,  /* 할인 값 (퍼센트 또는 금액) */
    minOrderPay decimal(10, 2),    /* 적용 가능한 최소 주문 금액 (옵션) */
    expirationDate date not null,      /* 만료일 */
    active char(3) default 'ON',      /* 쿠폰 활성화 여부(on, off) */
    primary key(idx),
    unique key (couponCode)
);

/* 쿠폰-회원 테이블 */
create table userCoupons (
    idx int not null auto_increment,
    couponIdx int not null,              /* 쿠폰*/
    mid	varchar(30) not null,                /* 사용자 ID (FK) */
    userCouponCode varchar(50) not null,              /* 발급된쿠폰코드 */
    used varchar(10) default 'NotUsed',       /* 쿠폰 사용 여부(used,NotUsed) */
    usedDate datetime,                    /* 쿠폰 사용 시각 (옵션) */
    primary key(idx), 
    foreign key(mid) references users(mid) on update cascade on delete cascade,  
    foreign key(couponIdx) references coupons(idx) on update cascade on delete restrict  
);


/* 배송테이블 */
create table baesong (
  idx     int not null auto_increment,
  oIdx    int not null,								/* 주문테이블의 고유번호를 외래키로 지정함 */
  orderIdx    varchar(15) not null,   /* 주문 고유번호 */
  orderTotalPrice int     not null,   /* 주문한 모든 상품의 총 가격 */
  mid         varchar(20) not null,   /* 회원 아이디 */
  name				varchar(30) not null,   /* 배송지 받는사람 이름 */
  address     varchar(100) not null,  /* 배송지 (우편번호)주소 */
  tel					varchar(15),						/* 받는사람 전화번호 */
  message     varchar(100),						/* 배송시 요청사항 */
  payment			varchar(10)  not null,	/* 결재도구 */
  payMethod   varchar(50)  not null,  /* 결재도구에 따른 방법(카드번호) */
  orderStatus varchar(10)  not null default '결제완료', /* 주문순서(결제완료->배송중->배송완료->구매완료) */
  primary key(idx),
  foreign key(oIdx) references productOrder(idx) on update cascade on delete restrict
);


