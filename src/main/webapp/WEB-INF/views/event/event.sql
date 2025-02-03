/* 이벤트 테이블 */
create table events (
    idx int not null auto_increment,      /* 이벤트 고유 ID */
    title varchar(50) NOT NULL,      /* 이벤트제목 */
    subTitle varchar(50),      /* 이벤트부제목 */
    thumbnail varchar(100) not null,		/* 이벤트 썸네일 */
    content text,                /* 이벤트 설명 */
    startDate date not null,              /* 이벤트 시작일 */
    endDate date not null,                /* 이벤트 종료일 */
    active char(3) default 'ON',          /* 이벤트 활성화 여부 (on, off) */
    couponCode varchar(50),               /* 적용할 쿠폰 코드 (옵션) */
    primary key (idx),
    foreign key (couponCode) references coupons(couponCode)    /* 쿠폰 테이블과 외래키 연결 */
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