
  $(function () {

    // MENU
    $('.nav-link').on('click',function(){
      $(".navbar-collapse").collapse('hide');
    });


    // AOS ANIMATION
    AOS.init({
      disable: 'mobile',
      duration: 800,
      anchorPlacement: 'center-bottom'
    });


    // SMOOTH SCROLL
    $(function() {
      $('.nav-link').on('click', function(event) {
        var $anchor = $(this);
          $('html, body').stop().animate({
            scrollTop: $($anchor.attr('href')).offset().top - 0
          }, 1000);
            event.preventDefault();
      });
    });  


    // PROJECT SLIDE
    $('#project-slide').owlCarousel({
      loop: true,
      center: true,
      autoplayHoverPause: false,
      autoplay: true,
      margin: 30,
      responsiveClass:true,
      responsive:{
          0:{
              items:1,
          },
          768:{
              items:2,
          }
      }
    });

  });
	
	//소아과 검
    var span;
    window.onload = function(){
        confirm = document.getElementById("result");


        if(navigator.geolocation){
            confirm.innerHTML = "Geolocation API를 지원합니다.";

            var options = {
                enableHighAcuurcy : true, /* 정확도설정 */
                timeout : 5000, /* 대기시간 */
                maximumAge : 3000 /* 캐시된 위치값을 반환받을 시간. 0으로 지정하면
                                    항상 최신의 현재위치를 수집한다. */
            };
            /*
            getCurrentPosition() : 현재 위치값을 얻어오는 함수
                사용법 : getCurrentPosition(
                            위치얻기에 성공했을 때 호출할 콜백메소드,
                            위치얻기에 실패했을 때 호출할 콜백메소드,
                            옵션(위치파악시간, 대기시간, 위치의정확도));  
            */
            navigator.geolocation.getCurrentPosition(showPosition, showError, options);
        }
        else{
        	confirm.innerHTML = "이 브라우저는 Geolocation API를 지원하지 않습니다.";
        }
    }

    //성공 시 호출할 콜백메소드
    var showPosition = function(position){
        //위도를 가져옴
        var latitude = position.coords.latitude;
        //경도를 가져옴
        var longitude = position.coords.longitude;
        //위,경도를 화면에 출력
        confirm.innerHTML  = "<img src='../resources/images/badge.png' style='width:20px;'/>"+" 현재 위치 확인 완료";
        
		////////////////////////////////////////////////////////////////////////
    	//위경도를 text input에 입력
    	document.getElementById("latTxt").value = latitude;
    	document.getElementById("lngTxt").value = longitude;
    	////////////////////////////////////////////////////////////////////////
    	
    }
    //실패 시 호출할 콜백메소드
    var showError = function(error){
        switch(error.code){
            case error.UNKNOWN_ERROR:
            	confirm.innerHTML = "알수없는오류발생";break;
            case error.PERMISSION_DENIED:
            	confirm.innerHTML = "권한이 없습니다";break;
            case error.POSITION_UNABAILABLE:
            	confirm.innerHTML = "위치 확인 불가";break;
            case error.TIMEOUT:
            	confirm.innerHTML = "시간초과";break;
        }
    }

    

