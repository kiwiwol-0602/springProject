<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Alfa+Slab+One&family=Playfair+Display:ital,wght@0,400..900;1,400..900&display=swap" rel="stylesheet">

	<style type="text/css">
	
		/* 로고 */
		@font-face { /*116수박화체 - 영문*/
			font-family: '116watermelon';
			src: url('https://gcore.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.0/116watermelon.woff') format('woff');
			font-weight: normal;
			font-style: normal;
		}
		
		/* 타이머 */
		@font-face { /*함박눈 - 붓글씨*/
		  font-family: 'SF_HambakSnow';
		  src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2106@1.1/SF_HambakSnow.woff') format('woff');
		  font-style: normal;
		}
		
		/* information */
		@font-face {	/*경기천년바탕 - 얇은 바탕체*/
	  	font-family: 'Gyeonggi_Batang_Regular';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2410-3@1.0/Batang_Regular.woff') format('woff');
	    font-style: normal;
		}
		
		@font-face { /*고운돋움 - 깔끔하고 얇음*/
    font-family: 'GowunDodum-Regular';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/GowunDodum-Regular.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
		
		@font-face {
    font-family: 'Gyeonggi_Title_Medium'; /* 경기천년제목 */ 
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2410-3@1.0/Title_Medium.woff') format('woff');
    font-weight: 500;
    font-style: normal;
		}
		
		@font-face { /*이순신돋움체 - 반듯반듯 고딕*/
	    font-family: 'YiSunShinDotumM';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YiSunShinDotumM.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
		}
		
		@font-face { /*학교안심받아쓰기 - 손글씨*/
	    font-family: 'HakgyoansimBadasseugiTTF-L';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2408-5@1.0/HakgyoansimBadasseugiTTF-L.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
		}
		
		@font-face { /*닉스곤 - 한글사용시 크기가 일정*/
			font-family: 'NIXGONM-Vb';
			src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/NIXGONM-Vb.woff') format('woff');
			font-weight: normal;
			font-style: normal;
		}
		
		@font-face { /*부크크 명조 - 두꺼운 바탕체*/
		  font-family: 'BookkMyungjo-Bd';
		  src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.0/BookkMyungjo-Bd.woff2') format('woff2');
		  font-weight: 700;
		  font-style: normal;
		}
		
		@font-face { /*고운바탕 - 얇은 필기체*/
	    font-family: 'GowunBatang-Regular';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/GowunBatang-Regular.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
		}
		
		@font-face { /*엘리스디지털배움체 - 한글 사용시 모서리 부분 처리가 독특함*/
	    font-family: 'EliceDigitalBaeum-Bd';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_elice@1.0/EliceDigitalBaeum-Bd.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
		}
		
		@font-face { /*G마켓 산스 - 예쁜 고딕*/
		    font-family: 'GmarketSansMedium';
		    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		
		@font-face { /*파셜산스 - 특이한 장식체*/
	    font-family: 'PartialSansKR-Regular';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2307-1@1.1/PartialSansKR-Regular.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
		}
		
		
		@font-face { /*북엔드 바탕 - 영문*/
	    font-family: 'TTBookendBatangR';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2410-2@1.0/TTBookendBatangR.woff2') format('woff2');
	    font-weight: 400;
	    font-style: normal;
		}
		
		@font-face { /*조선일보명조체 - 신문체, 영문추천*/
	    font-family: 'Chosunilbo_myungjo';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/Chosunilbo_myungjo.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
		}
		
		@font-face { /*조선굴림체 - 동글 고딕*/
		    font-family: 'ChosunGu';
		    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@1.0/ChosunGu.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		
		@font-face { /*둘기마요고딕 - 동글 얇*/
	    font-family: 'Dovemayo_gothic'; 
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.1/Dovemayo_gothic.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
		}
		
		@font-face { /*긱블 말랑이체 - 동글 두껍*/
	    font-family: 'GeekbleMalang2WOFF2'; 
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/GeekbleMalang2WOFF2.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
		}

		@font-face { /*삼립호빵체 - outline이라 가운데 흰색, 테두리 검정*/
	    font-family: 'SDSamliphopangche_Outline'; 
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts-20-12@1.0/SDSamliphopangche_Outline.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
		}	
		
		@font-face { /*수트 - 네모 딱딱 고딕*/
	    font-family: 'SUIT-Regular';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
		}
		
		@font-face { /*눈누 기초고딕 - 두꺼운 네모 딱딱 고딕*/
	    font-family: 'NoonnuBasicGothicRegular';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noon-2410@1.0/NoonnuBasicGothicRegular.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
		}
		
		@font-face { /*단조 - 두꺼운 뾰족뾰족 모서리 바탕*/
		    font-family: 'Danjo-bold-Regular';
		    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2307-1@1.1/Danjo-bold-Regular.woff2') format('woff2');
		    font-weight: normal;
		    font-style: normal;
		}
		
		@font-face { /*가나초콜릿체 - 가나 포장지 글씨체*/
	    font-family: 'ghanachoco';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@1.0/ghanachoco.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
		}
		
		@font-face {
	    font-family: 'kdg_Medium';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts-20-12@1.0/kdg_Medium.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
		}
		
	</style>
