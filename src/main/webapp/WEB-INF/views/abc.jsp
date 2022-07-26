<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>kakao Map API</h1>


	<div id="map" style="width: 800px; height: 600px;"></div>
	<p>
		<em>지도를 클릭해주세요!</em>
	</p>
	<div id="clickLatlng"></div>
	<input id="address" type="text">
	<input type="button" onclick="send_address();" value="입력">
	<div id="address_wrong"></div>
	<div id="length"></div>



	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1238e8951563cac78b42514b9f16f01e&libraries=services"></script>


	<script>
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center : new kakao.maps.LatLng(37.58444802225524,
					126.96998327746174), //지도의 중심좌표.
			level : 3
		//지도의 레벨(확대, 축소 정도)
		};

		var map = new kakao.maps.Map(container, options); // 지도 생성

		var marker2 = new kakao.maps.Marker({
			position : map.getCenter()
		}); // 마커생성

		marker2.setMap(map);
		marker2.setDraggable(true);

		var lat = marker2.getPosition().getLat();
		var lng = marker2.getPosition().getLng();

		var triPath = [ new kakao.maps.LatLng(lat, lng),
				new kakao.maps.LatLng(37.586389669944964, 126.97001363335632),
				new kakao.maps.LatLng(37.58508297592968, 126.96902915912662) ];

		var polygonPath = [
				new kakao.maps.LatLng(37.58432807483288, 126.96783503187012),
				new kakao.maps.LatLng(37.582327958849696, 126.96816421309038),
				new kakao.maps.LatLng(37.58232840463374, 126.96986242340829),
				new kakao.maps.LatLng(37.58282442397657, 126.97177555332996),
				new kakao.maps.LatLng(37.58423877169243, 126.97090324901453) ];

		var tri = new kakao.maps.Polygon({
			path : triPath, // 그려질 다각형의 좌표 배열입니다
			strokeWeight : 3, // 선의 두께입니다
			strokeColor : '#39DE2A', // 선의 색깔입니다
			strokeOpacity : 0.8, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
			strokeStyle : 'longdash', // 선의 스타일입니다
			fillColor : '#A2FF99', // 채우기 색깔입니다
			fillOpacity : 0.7
		// 채우기 불투명도 입니다
		})

		// 지도에 표시할 다각형을 생성합니다
		var polygon = new kakao.maps.Polygon({
			path : polygonPath, // 그려질 다각형의 좌표 배열입니다
			strokeWeight : 3, // 선의 두께입니다
			strokeColor : '#39DE2A', // 선의 색깔입니다
			strokeOpacity : 0.8, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
			strokeStyle : 'longdash', // 선의 스타일입니다
			fillColor : '#A2FF99', // 채우기 색깔입니다
			fillOpacity : 0.7
		// 채우기 불투명도 입니다
		});

		// 지도에 다각형을 표시합니다
		tri.setMap(map);
		polygon.setMap(map);

		var poly_marker_list = [ new kakao.maps.Marker({
			position : polygon.getPath()[0]
		}), new kakao.maps.Marker({
			position : polygon.getPath()[1]
		}), new kakao.maps.Marker({
			position : polygon.getPath()[2]
		}), new kakao.maps.Marker({
			position : polygon.getPath()[3]
		}), new kakao.maps.Marker({
			position : polygon.getPath()[4]
		}) ];

		poly_marker_list[0].setMap(map);
		poly_marker_list[1].setMap(map);
		poly_marker_list[2].setMap(map);
		poly_marker_list[3].setMap(map);
		poly_marker_list[4].setMap(map);

		for (var i = 0; i < Object.keys(polygonPath).length; i++) {
			var point1 = poly_marker_list[i].getPosition();
			var point2 = poly_marker_list[(i + 1)
					% Object.keys(polygonPath).length].getPosition();

			var eachLine = new kakao.maps.Polygon({
				strokeWeight : 3, // 선의 두께입니다
				strokeColor : '#39DE2A', // 선의 색깔입니다
				strokeOpacity : 0.8, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
				strokeStyle : 'longdash', // 선의 스타일입니다
				fillColor : '#A2FF99', // 채우기 색깔입니다
				fillOpacity : 0.7
			// 채우기 불투명도 입니다
			});

			var path = eachLine.getPath();
			path.push(point1);
			path.push(point2);


			eachLine.setPath(path);


			var distance = Math.round(eachLine.getLength()) / 2;

			var infowindow = new kakao.maps.InfoWindow(
					{
						position : new kakao.maps.LatLng(
								(poly_marker_list[i].getPosition().getLat() + poly_marker_list[(i + 1)
										% Object.keys(polygonPath).length]
										.getPosition().getLat()) / 2,
								(poly_marker_list[i].getPosition().getLng() + poly_marker_list[(i + 1)
										% Object.keys(polygonPath).length]
										.getPosition().getLng()) / 2),
						content : '<div style="width:150px;text-align:center;padding:6px 0;">'
								+ distance + 'M' + '</div>'
					});
			infowindow.open(map);

		}

		var length = document.getElementById('length');
		length.innerHTML = polygon.getLength().toFixed(2) + 'm';

		console.log(typeof (polygonPath));
		console.log(Object.keys(polygonPath).length);
	</script>

	<script>
		var xhr = new XMLHttpRequest();
		var url = 'http://apis.data.go.kr/3160000/guroPm25DvcInfoSvc/getGuroComSvCtPm25Dvc'; /*URL*/
		var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 's3FCx6soPjML6rIQUv7s9zFT222uWpkTQ6V1XaJbpXjIXE16aAHt06hXMtU7x5cikt2nk6HU%2BdybfSSzPy3juA%3D%3D'; /*Service Key*/
		queryParams += '&' + encodeURIComponent('returnType') + '='
				+ encodeURIComponent('xml'); /**/
		queryParams += '&' + encodeURIComponent('numOfRows') + '='
				+ encodeURIComponent('10'); /**/
		queryParams += '&' + encodeURIComponent('pageNo') + '='
				+ encodeURIComponent('1'); /**/
		xhr.open('GET', url + queryParams);
		xhr.onreadystatechange = function() {
			if (this.readyState == 4) {
				var xml = xhr.responseXML;
				
				var items = xml.getElementsByTagName('item');
				var itemsLon = xml.getElementsByTagName('lon');
				var itemsLat = xml.getElementsByTagName('lat');
				var markerList = new Array();
				
				for(var i=0; i<items.length; i++) {
					var lon = itemsLon[i].childNodes[0].data;
					var lat = itemsLat[i].childNodes[0].data;
					var ApiMarker = new kakao.maps.Marker({
						position : new kakao.maps.LatLng(lat, lon)
					}); // 마커생성
					
					markerList.push(ApiMarker);
				}
				
				for(var i=0; i<markerList.length; i++) {
					markerList[i].setMap(map);
				}
				
				
			}
		};

		xhr.send('');
	</script>

	<script>
		// 클릭이벤트
		kakao.maps.event.addListener(map, 'click',
				function(mouseEvent) {

					tri.setMap(null);

					// 클릭한 위도, 경도 정보를 가져옵니다 
					var latlng = mouseEvent.latLng;
					lat = latlng.getLat();
					lng = latlng.getLng();

					// 마커 위치를 클릭한 위치로 옮깁니다
					marker2.setPosition(latlng);
					//tri.setMap(map);
					tri.setPath([
							new kakao.maps.LatLng(lat, lng),
							new kakao.maps.LatLng(37.586389669944964,
									126.97001363335632),
							new kakao.maps.LatLng(37.58508297592968,
									126.96902915912662) ]);

					tri.setMap(map);
					console.log('위도 = ' + latlng.getLat() + " 경도 = "
							+ latlng.getLng());

					var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
					message += '경도는 ' + latlng.getLng() + ' 입니다';

					var resultDiv = document.getElementById('clickLatlng');
					resultDiv.innerHTML = message;

				});

		//드래그 이벤트

		kakao.maps.event.addListener(marker2, 'dragstart', function() {
			var latlng = marker2.getPosition();
			lat = latlng.getLat();
			lng = latlng.getLng();

			console.log('lat = ' + lat + ' lng = ' + lng);
			tri.setMap(null);
			tri
					.setPath([
							new kakao.maps.LatLng(lat, lng),
							new kakao.maps.LatLng(37.586389669944964,
									126.97001363335632),
							new kakao.maps.LatLng(37.58508297592968,
									126.96902915912662) ]);
			tri.setMap(map);
		});
		
		kakao.maps.event.addListener(marker2, 'drag', function() {
			console.log('hihihi');
		});
		
		kakao.maps.event.addListener(marker2, 'dragend', function() {
			var latlng = marker2.getPosition();
			lat = latlng.getLat();
			lng = latlng.getLng();

			console.log('lat = ' + lat + ' lng = ' + lng);
			tri.setMap(null);
			tri
					.setPath([
							new kakao.maps.LatLng(lat, lng),
							new kakao.maps.LatLng(37.586389669944964,
									126.97001363335632),
							new kakao.maps.LatLng(37.58508297592968,
									126.96902915912662) ]);
			tri.setMap(map);
		});
	</script>

	<script>
		function send_address() {

			var geocoder = new kakao.maps.services.Geocoder();
			var address = document.getElementById('address').value;
			var address_wrong = document.getElementById('address_wrong');
			geocoder
					.addressSearch(
							address,
							function(result, status) {

								// 정상적으로 검색이 완료됐으면 
								if (status === kakao.maps.services.Status.OK) {

									address_wrong.innerHTML = ' ';
									var coords = new kakao.maps.LatLng(
											result[0].y, result[0].x);

									// 결과값으로 받은 위치를 마커로 표시합니다
									var marker = new kakao.maps.Marker({
										map : map,
										position : coords
									});

									// 인포윈도우로 장소에 대한 설명을 표시합니다
									var infowindow = new kakao.maps.InfoWindow(
											{
												content : '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
											});
									infowindow.open(map, marker);

									// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
									map.setCenter(coords);
								} else {
									address_wrong.innerHTML = '잘못된 주소입니다.';
								}
							});
		}
	</script>

</body>
</html>