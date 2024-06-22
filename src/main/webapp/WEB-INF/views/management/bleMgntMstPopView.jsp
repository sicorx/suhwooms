<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>


<style>

#realInfoDiv td 
{ 
	border:1px solid;
	text-align:center;
}


#storeInfoDiv td 
{ 
	border:1px solid;
	text-align:center;
}

#elecInfoDiv td 
{ 
	border:1px solid;
	text-align:center;
}

#networkInfoDiv td 
{
	border:1px solid;
	text-align:center;
}

#sensorInfoDiv td 
{
	border:1px solid;
	text-align:center;
}



#realInfoDiv th
{ 
	border:1px solid;
	text-align:center;
	background-color:rgba(216,216,216,1);
}

#storeInfoDiv th
{ 
	border:1px solid;
	text-align:center;
	background-color:rgba(216,216,216,1);
}

#elecInfoDiv th
{ 
	border:1px solid;
	text-align:center;
	background-color:rgba(216,216,216,1);
}

#networkInfoDiv th
{ 
	border:1px solid;
	text-align:center;
	background-color:rgba(216,216,216,1);
}

#sensorInfoDiv th
{ 
	border:1px solid;
	text-align:center;
	background-color:rgba(216,216,216,1);
}

.title
{
	background-color:rgba(189,189,189,1);
}

.legend
{
	background-color:rgba(216,216,216,1);
}



</style>

<script type="text/javascript">


/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function() {
			
	console.log( '${elecInfo}' );
	
	// 실수집 데이터
	
	var realDataInfo = JSON.parse('${realDataInfo}');
	
	// 전기업체
	var elecInfo = 		JSON.parse('${elecInfo}');
	var sensorInfo = 	JSON.parse('${sensorInfo}');
	var networkInfo = 	JSON.parse('${networkInfo}');
	var networkIp = 	JSON.parse('${networkip}');
	
	
	if( networkIp.length != 0)
	{
		$('#strCd').text( 			networkIp[0].strCd );
		$('#strNm').text( 			networkIp[0].strNm );
		$('#viewStrCd').text( 		networkIp[0].viewStrCd );
		$('#gwId').text( 			networkIp[0].gwId );
		$('#mac').text( 			networkIp[0].mac );
		
		$('#gwIp').text( 			networkIp[0].gwIp );
		$('#gwNetmask').text( 		networkIp[0].gwNetmask );
		$('#gwGateway').text( 		networkIp[0].gwGateway );
		$('#ifIp').text( 			networkIp[0].ifIp );
		$('#ifPort').text( 			networkIp[0].ifPort );
	}
	
	elecInfoCheck( 		realDataInfo, 0 );
	sensorInfoCheck( 		realDataInfo, 0 );
	deviceInfoCheck( 		realDataInfo, 0 );
	
	elecInfoCheck( 		elecInfo, 1 );
	sensorInfoCheck( 	elecInfo, 1 );
	deviceInfoCheck( 	elecInfo, 1 );
	
	
	// 유지보수업체
	var sensorInfo = JSON.parse('${sensorInfo}');
	elecInfoCheck( 		sensorInfo, 2 );
	sensorInfoCheck( 	sensorInfo, 2 );
	deviceInfoCheck( 	sensorInfo, 2 );
	
	// 시스네트 업체
	var networkInfo = JSON.parse('${networkInfo}');
	elecInfoCheck( 		networkInfo, 3 );
	sensorInfoCheck( 	networkInfo, 3 );
	deviceInfoCheck( 	networkInfo, 3 );
	
	
	
	// 간판 업체
	var signInfo = JSON.parse('${signInfo}');
	//elecInfoCheck( 		signInfo, 4 );
	sensorInfoCheck( 	signInfo, 4 );
	//deviceInfoCheck( 	signInfo, 4 );
	
	
	
	

});


function elecInfoCheck(info, userType)
{
	
	if( info.length == 0 )
		return;
	
	var epCnt = 				info[0].epCnt;
	var rst = 					info[0].rst;
	
	var ep1chAcc = 				info[0].ep1chAcc;
	var ep1chInst = 			info[0].ep1chInst;
	var ep1chStatus = 			info[0].ep1chStatus;
	var ep2chAcc = 				info[0].ep2chAcc;
	var ep2chInst = 			info[0].ep2chInst;
	var ep2chStatus = 			info[0].ep2chStatus;
	var ep3chAcc = 				info[0].ep3chAcc;
	var ep3chInst = 			info[0].ep3chInst;
	var ep3chStatus = 			info[0].ep3chStatus;
	var ep4chAcc = 				info[0].ep4chAcc;
	var ep4chInst = 			info[0].ep4chInst;
	var ep4chStatus = 			info[0].ep4chStatus;
	var ep5chAcc = 				info[0].ep5chAcc;
	var ep5chInst = 			info[0].ep5chInst;
	var ep5chStatus = 			info[0].ep5chStatus;
	var ep6chAcc = 				info[0].ep6chAcc;
	var ep6chInst = 			info[0].ep6chInst;
	var ep6chStatus = 			info[0].ep6chStatus;
	var ep7chRAcc = 			info[0].ep7chRAcc;
	var ep7chRInst = 			info[0].ep7chRInst;
	var ep7chRStatus = 			info[0].ep7chRStatus;
	var ep7chSAcc = 			info[0].ep7chSAcc;
	var ep7chSInst = 			info[0].ep7chSInst;
	var ep7chSStatus = 			info[0].ep7chSStatus;
	var ep7chTAcc = 			info[0].ep7chTAcc;
	var ep7chTInst = 			info[0].ep7chTInst;
	var ep7chTStatus = 			info[0].ep7chTStatus;
	var ep8chRAcc = 			info[0].ep8chRAcc;
	var ep8chRInst = 			info[0].ep8chRInst;
	var ep8chRStatus = 			info[0].ep8chRStatus;
	var ep8chSAcc = 			info[0].ep8chSAcc;
	var ep8chSInst = 			info[0].ep8chSInst;
	var ep8chSStatus = 			info[0].ep8chSStatus;
	var ep8chTAcc = 			info[0].ep8chTAcc;
	var ep8chTInst = 			info[0].ep8chTInst;
	var ep8chTStatus = 			info[0].ep8chTStatus;	
	
	
	
	if( userType == 0 )
	{	
		$('#realEp1chAcc').text( 				ep1chAcc );
		$('#realEp1chInst').text( 				ep1chInst );
		$('#realEp1chStatus').text( 			ep1chStatus );
		$('#realEp2chAcc').text( 				ep2chAcc );
		$('#realEp2chInst').text( 				ep2chInst );
		$('#realEp2chStatus').text( 			ep2chStatus );
		$('#realEp3chAcc').text( 				ep3chAcc );
		$('#realEp3chInst').text( 				ep3chInst );
		$('#realEp3chStatus').text( 			ep3chStatus );
		$('#realEp4chAcc').text( 				ep4chAcc );
		$('#realEp4chInst').text( 				ep4chInst );
		$('#realEp4chStatus').text( 			ep4chStatus );
		$('#realEp5chAcc').text( 				ep5chAcc );
		$('#realEp5chInst').text( 				ep5chInst );
		$('#realEp5chStatus').text( 			ep5chStatus );
		$('#realEp6chAcc').text( 				ep6chAcc );
		$('#realEp6chInst').text( 				ep6chInst );
		$('#realEp6chStatus').text( 			ep6chStatus );
		$('#realEp7chRAcc').text( 				ep7chRAcc );
		$('#realEp7chRInst').text( 				ep7chRInst );
		$('#realEp7chRStatus').text( 			ep7chRStatus );	
		$('#realEp7chSAcc').text( 				ep7chSAcc );
		$('#realEp7chSInst').text( 				ep7chSInst );
		$('#realEp7chSStatus').text( 			ep7chSStatus );
		$('#realEp7chTAcc').text( 				ep7chTAcc );
		$('#realEp7chTInst').text( 				ep7chTInst );
		$('#realEp7chTStatus').text( 			ep7chTStatus );
		$('#realEp8chRAcc').text( 				ep8chRAcc );
		$('#realEp8chRInst').text( 				ep8chRInst );
		$('#realEp8chRStatus').text( 			ep8chRStatus );	
		$('#realEp8chSAcc').text( 				ep8chSAcc );
		$('#realEp8chSInst').text( 				ep8chSInst );
		$('#realEp8chSStatus').text( 			ep8chSStatus );
		$('#realEp8chTAcc').text( 				ep8chTAcc );
		$('#realEp8chTInst').text( 				ep8chTInst );
		$('#realEp8chTStatus').text( 			ep8chTStatus );
		
		$('#realChannelCnt').text( 				epCnt );
		$('#realRST').text( 					rst );
	}
	
	if( userType == 1 )
	{	
		$('#elecEp1chAcc').text( 				ep1chAcc );
		$('#elecEp1chInst').text( 				ep1chInst );
		$('#elecEp1chStatus').text( 			ep1chStatus );
		$('#elecEp2chAcc').text( 				ep2chAcc );
		$('#elecEp2chInst').text( 				ep2chInst );
		$('#elecEp2chStatus').text( 			ep2chStatus );
		$('#elecEp3chAcc').text( 				ep3chAcc );
		$('#elecEp3chInst').text( 				ep3chInst );
		$('#elecEp3chStatus').text( 			ep3chStatus );
		$('#elecEp4chAcc').text( 				ep4chAcc );
		$('#elecEp4chInst').text( 				ep4chInst );
		$('#elecEp4chStatus').text( 			ep4chStatus );
		$('#elecEp5chAcc').text( 				ep5chAcc );
		$('#elecEp5chInst').text( 				ep5chInst );
		$('#elecEp5chStatus').text( 			ep5chStatus );
		$('#elecEp6chAcc').text( 				ep6chAcc );
		$('#elecEp6chInst').text( 				ep6chInst );
		$('#elecEp6chStatus').text( 			ep6chStatus );
		$('#elecEp7chRAcc').text( 				ep7chRAcc );
		$('#elecEp7chRInst').text( 				ep7chRInst );
		$('#elecEp7chRStatus').text( 			ep7chRStatus );	
		$('#elecEp7chSAcc').text( 				ep7chSAcc );
		$('#elecEp7chSInst').text( 				ep7chSInst );
		$('#elecEp7chSStatus').text( 			ep7chSStatus );
		$('#elecEp7chTAcc').text( 				ep7chTAcc );
		$('#elecEp7chTInst').text( 				ep7chTInst );
		$('#elecEp7chTStatus').text( 			ep7chTStatus );
		$('#elecEp8chRAcc').text( 				ep8chRAcc );
		$('#elecEp8chRInst').text( 				ep8chRInst );
		$('#elecEp8chRStatus').text( 			ep8chRStatus );	
		$('#elecEp8chSAcc').text( 				ep8chSAcc );
		$('#elecEp8chSInst').text( 				ep8chSInst );
		$('#elecEp8chSStatus').text( 			ep8chSStatus );
		$('#elecEp8chTAcc').text( 				ep8chTAcc );
		$('#elecEp8chTInst').text( 				ep8chTInst );
		$('#elecEp8chTStatus').text( 			ep8chTStatus );
		
		$('#elecChannelCnt').text( 				epCnt );
		$('#elecRST').text( 					rst );
	}
	
	if( userType == 2 )
	{	
		$('#sensorEp1chAcc').text( 				ep1chAcc );
		$('#sensorEp1chInst').text( 				ep1chInst );
		$('#sensorEp1chStatus').text( 			ep1chStatus );
		$('#sensorEp2chAcc').text( 				ep2chAcc );
		$('#sensorEp2chInst').text( 				ep2chInst );
		$('#sensorEp2chStatus').text( 			ep2chStatus );
		$('#sensorEp3chAcc').text( 				ep3chAcc );
		$('#sensorEp3chInst').text( 				ep3chInst );
		$('#sensorEp3chStatus').text( 			ep3chStatus );
		$('#sensorEp4chAcc').text( 				ep4chAcc );
		$('#sensorEp4chInst').text( 				ep4chInst );
		$('#sensorEp4chStatus').text( 			ep4chStatus );
		$('#sensorEp5chAcc').text( 				ep5chAcc );
		$('#sensorEp5chInst').text( 				ep5chInst );
		$('#sensorEp5chStatus').text( 			ep5chStatus );
		$('#sensorEp6chAcc').text( 				ep6chAcc );
		$('#sensorEp6chInst').text( 				ep6chInst );
		$('#sensorEp6chStatus').text( 			ep6chStatus );
		$('#sensorEp7chRAcc').text( 				ep7chRAcc );
		$('#sensorEp7chRInst').text( 				ep7chRInst );
		$('#sensorEp7chRStatus').text( 			ep7chRStatus );	
		$('#sensorEp7chSAcc').text( 				ep7chSAcc );
		$('#sensorEp7chSInst').text( 				ep7chSInst );
		$('#sensorEp7chSStatus').text( 			ep7chSStatus );
		$('#sensorEp7chTAcc').text( 				ep7chTAcc );
		$('#sensorEp7chTInst').text( 				ep7chTInst );
		$('#sensorEp7chTStatus').text( 			ep7chTStatus );
		$('#sensorEp8chRAcc').text( 				ep8chRAcc );
		$('#sensorEp8chRInst').text( 				ep8chRInst );
		$('#sensorEp8chRStatus').text( 			ep8chRStatus );	
		$('#sensorEp8chSAcc').text( 				ep8chSAcc );
		$('#sensorEp8chSInst').text( 				ep8chSInst );
		$('#sensorEp8chSStatus').text( 			ep8chSStatus );
		$('#sensorEp8chTAcc').text( 				ep8chTAcc );
		$('#sensorEp8chTInst').text( 				ep8chTInst );
		$('#sensorEp8chTStatus').text( 			ep8chTStatus );
		
		$('#sensorChannelCnt').text( 				epCnt );
		$('#sensorRST').text( 					rst );
	}
	
	if( userType == 3 )
	{	
		$('#networkEp1chAcc').text( 				ep1chAcc );
		$('#networkEp1chInst').text( 				ep1chInst );
		$('#networkEp1chStatus').text( 			ep1chStatus );
		$('#networkEp2chAcc').text( 				ep2chAcc );
		$('#networkEp2chInst').text( 				ep2chInst );
		$('#networkEp2chStatus').text( 			ep2chStatus );
		$('#networkEp3chAcc').text( 				ep3chAcc );
		$('#networkEp3chInst').text( 				ep3chInst );
		$('#networkEp3chStatus').text( 			ep3chStatus );
		$('#networkEp4chAcc').text( 				ep4chAcc );
		$('#networkEp4chInst').text( 				ep4chInst );
		$('#networkEp4chStatus').text( 			ep4chStatus );
		$('#networkEp5chAcc').text( 				ep5chAcc );
		$('#networkEp5chInst').text( 				ep5chInst );
		$('#networkEp5chStatus').text( 			ep5chStatus );
		$('#networkEp6chAcc').text( 				ep6chAcc );
		$('#networkEp6chInst').text( 				ep6chInst );
		$('#networkEp6chStatus').text( 			ep6chStatus );
		$('#networkEp7chRAcc').text( 				ep7chRAcc );
		$('#networkEp7chRInst').text( 				ep7chRInst );
		$('#networkEp7chRStatus').text( 			ep7chRStatus );	
		$('#networkEp7chSAcc').text( 				ep7chSAcc );
		$('#networkEp7chSInst').text( 				ep7chSInst );
		$('#networkEp7chSStatus').text( 			ep7chSStatus );
		$('#networkEp7chTAcc').text( 				ep7chTAcc );
		$('#networkEp7chTInst').text( 				ep7chTInst );
		$('#networkEp7chTStatus').text( 			ep7chTStatus );
		$('#networkEp8chRAcc').text( 				ep8chRAcc );
		$('#networkEp8chRInst').text( 				ep8chRInst );
		$('#networkEp8chRStatus').text( 			ep8chRStatus );	
		$('#networkEp8chSAcc').text( 				ep8chSAcc );
		$('#networkEp8chSInst').text( 				ep8chSInst );
		$('#networkEp8chSStatus').text( 			ep8chSStatus );
		$('#networkEp8chTAcc').text( 				ep8chTAcc );
		$('#networkEp8chTInst').text( 				ep8chTInst );
		$('#networkEp8chTStatus').text( 			ep8chTStatus );
		
		$('#networkChannelCnt').text( 				epCnt );
		$('#networkRST').text( 					rst );
	}
	
	//alert( infoSize + " / " + StrCd + " / " + epCnt + " / " + ep1chAcc + " / " + ep1chInst + " / " + ep1chStatus );
}

function sensorInfoCheck(info, userType)
{

	if( info.length == 0 )
		return;
	
	
	var haconTempN1 = 				info[0].haconTempN1;
	var haconTempN2 = 				info[0].haconTempN2;
	var haconTempN3 = 				info[0].haconTempN3;
	var haconTempN4 = 				info[0].haconTempN4;
	var haconTempN5 = 				info[0].haconTempN5;
	
	var haconStatusN1 = 			info[0].haconStatusN1;
	var haconStatusN2 = 			info[0].haconStatusN2;
	var haconStatusN3 = 			info[0].haconStatusN3;
	var haconStatusN4 = 			info[0].haconStatusN4;
	var haconStatusN5 = 			info[0].haconStatusN5;	
	
	var haconExistN1 = 				info[0].haconExistN1;
	var haconExistN2 = 				info[0].haconExistN2;
	var haconExistN3 = 				info[0].haconExistN3;
	var haconExistN4 = 				info[0].haconExistN4;
	var haconExistN5 = 				info[0].haconExistN5;
	
	var tSensorTempN1 = 				info[0].tSensorTempN1;
	var tSensorTempN2 = 				info[0].tSensorTempN2;
	var tSensorTempN3 = 				info[0].tSensorTempN3;
	var tSensorTempN4 = 				info[0].tSensorTempN4;
	var tSensorTempN5 = 				info[0].tSensorTempN5;
	
	var tSensorStatusN1 = 			info[0].tSensorStatusN1;
	var tSensorStatusN2 = 			info[0].tSensorStatusN2;
	var tSensorStatusN3 = 			info[0].tSensorStatusN3;
	var tSensorStatusN4 = 			info[0].tSensorStatusN4;
	var tSensorStatusN5 = 			info[0].tSensorStatusN5;	
	
	var tSensorExistN1 = 				info[0].tSensorExistN1;
	var tSensorExistN2 = 				info[0].tSensorExistN2;
	var tSensorExistN3 = 				info[0].tSensorExistN3;
	var tSensorExistN4 = 				info[0].tSensorExistN4;
	var tSensorExistN5 = 				info[0].tSensorExistN5;
	
	var signStatus = 				info[0].signStatus;
	var signOnOff = 				info[0].signOnOff;
	
	if( userType == 0 )
	{
		$('#realHaconTempN1').text( 				haconTempN1 );
		$('#realHaconTempN2').text( 				haconTempN2 );
		$('#realHaconTempN3').text( 				haconTempN3 );
		$('#realHaconTempN4').text( 				haconTempN4 );
		$('#realHaconTempN5').text( 				haconTempN5 );
			
		$('#realHaconStatusN1').text( 				haconStatusN1 );
		$('#realHaconStatusN2').text( 				haconStatusN2 );
		$('#realHaconStatusN3').text( 				haconStatusN3 );
		$('#realHaconStatusN4').text( 				haconStatusN4 );
		$('#realHaconStatusN5').text( 				haconStatusN5 );
	
		$('#realHaconExistN1').text( 				haconExistN1 );
		$('#realHaconExistN2').text( 				haconExistN2 );
		$('#realHaconExistN3').text( 				haconExistN3 );
		$('#realHaconExistN4').text( 				haconExistN4 );
		$('#realHaconExistN5').text( 				haconExistN5 );
		
		$('#realTSensorTempN1').text( 				tSensorTempN1 );
		$('#realTSensorTempN2').text( 				tSensorTempN2 );
		$('#realTSensorTempN3').text( 				tSensorTempN3 );
		$('#realTSensorTempN4').text( 				tSensorTempN4 );
		$('#realTSensorTempN5').text( 				tSensorTempN5 );
			
		$('#realTSensorStatusN1').text( 				tSensorStatusN1 );
		$('#realTSensorStatusN2').text( 				tSensorStatusN2 );
		$('#realTSensorStatusN3').text( 				tSensorStatusN3 );
		$('#realTSensorStatusN4').text( 				tSensorStatusN4 );
		$('#realTSensorStatusN5').text( 				tSensorStatusN5 );
	
		$('#realTSensorExistN1').text( 				tSensorExistN1 );
		$('#realTSensorExistN2').text( 				tSensorExistN2 );
		$('#realTSensorExistN3').text( 				tSensorExistN3 );
		$('#realTSensorExistN4').text( 				tSensorExistN4 );
		$('#realTSensorExistN5').text( 				tSensorExistN5 );
		
		$('#realSignStatus').text( 					signStatus );
		$('#realSignOnOff').text( 					signOnOff );
	}
	
	if( userType == 1 )
	{
		$('#elecHaconTempN1').text( 				haconTempN1 );
		$('#elecHaconTempN2').text( 				haconTempN2 );
		$('#elecHaconTempN3').text( 				haconTempN3 );
		$('#elecHaconTempN4').text( 				haconTempN4 );
		$('#elecHaconTempN5').text( 				haconTempN5 );
			
		$('#elecHaconStatusN1').text( 				haconStatusN1 );
		$('#elecHaconStatusN2').text( 				haconStatusN2 );
		$('#elecHaconStatusN3').text( 				haconStatusN3 );
		$('#elecHaconStatusN4').text( 				haconStatusN4 );
		$('#elecHaconStatusN5').text( 				haconStatusN5 );
	
		$('#elecHaconExistN1').text( 				haconExistN1 );
		$('#elecHaconExistN2').text( 				haconExistN2 );
		$('#elecHaconExistN3').text( 				haconExistN3 );
		$('#elecHaconExistN4').text( 				haconExistN4 );
		$('#elecHaconExistN5').text( 				haconExistN5 );
		
		$('#elecTSensorTempN1').text( 				tSensorTempN1 );
		$('#elecTSensorTempN2').text( 				tSensorTempN2 );
		$('#elecTSensorTempN3').text( 				tSensorTempN3 );
		$('#elecTSensorTempN4').text( 				tSensorTempN4 );
		$('#elecTSensorTempN5').text( 				tSensorTempN5 );
			
		$('#elecTSensorStatusN1').text( 				tSensorStatusN1 );
		$('#elecTSensorStatusN2').text( 				tSensorStatusN2 );
		$('#elecTSensorStatusN3').text( 				tSensorStatusN3 );
		$('#elecTSensorStatusN4').text( 				tSensorStatusN4 );
		$('#elecTSensorStatusN5').text( 				tSensorStatusN5 );
	
		$('#elecTSensorExistN1').text( 				tSensorExistN1 );
		$('#elecTSensorExistN2').text( 				tSensorExistN2 );
		$('#elecTSensorExistN3').text( 				tSensorExistN3 );
		$('#elecTSensorExistN4').text( 				tSensorExistN4 );
		$('#elecTSensorExistN5').text( 				tSensorExistN5 );
		
		$('#elecSignStatus').text( 					signStatus );
		$('#elecSignOnOff').text( 					signOnOff );
	}
	
	if( userType == 2 )
	{
		$('#sensorHaconTempN1').text( 				haconTempN1 );
		$('#sensorHaconTempN2').text( 				haconTempN2 );
		$('#sensorHaconTempN3').text( 				haconTempN3 );
		$('#sensorHaconTempN4').text( 				haconTempN4 );
		$('#sensorHaconTempN5').text( 				haconTempN5 );
			
		$('#sensorHaconStatusN1').text( 				haconStatusN1 );
		$('#sensorHaconStatusN2').text( 				haconStatusN2 );
		$('#sensorHaconStatusN3').text( 				haconStatusN3 );
		$('#sensorHaconStatusN4').text( 				haconStatusN4 );
		$('#sensorHaconStatusN5').text( 				haconStatusN5 );
	
		$('#sensorHaconExistN1').text( 				haconExistN1 );
		$('#sensorHaconExistN2').text( 				haconExistN2 );
		$('#sensorHaconExistN3').text( 				haconExistN3 );
		$('#sensorHaconExistN4').text( 				haconExistN4 );
		$('#sensorHaconExistN5').text( 				haconExistN5 );
		
		$('#sensorTSensorTempN1').text( 				tSensorTempN1 );
		$('#sensorTSensorTempN2').text( 				tSensorTempN2 );
		$('#sensorTSensorTempN3').text( 				tSensorTempN3 );
		$('#sensorTSensorTempN4').text( 				tSensorTempN4 );
		$('#sensorTSensorTempN5').text( 				tSensorTempN5 );
			
		$('#sensorTSensorStatusN1').text( 				tSensorStatusN1 );
		$('#sensorTSensorStatusN2').text( 				tSensorStatusN2 );
		$('#sensorTSensorStatusN3').text( 				tSensorStatusN3 );
		$('#sensorTSensorStatusN4').text( 				tSensorStatusN4 );
		$('#sensorTSensorStatusN5').text( 				tSensorStatusN5 );
	
		$('#sensorTSensorExistN1').text( 				tSensorExistN1 );
		$('#sensorTSensorExistN2').text( 				tSensorExistN2 );
		$('#sensorTSensorExistN3').text( 				tSensorExistN3 );
		$('#sensorTSensorExistN4').text( 				tSensorExistN4 );
		$('#sensorTSensorExistN5').text( 				tSensorExistN5 );
		
		$('#sensorSignStatus').text( 					signStatus );
		$('#sensorSignOnOff').text( 					signOnOff );
	}
	
	if( userType == 3 )
	{
		$('#networkHaconTempN1').text( 				haconTempN1 );
		$('#networkHaconTempN2').text( 				haconTempN2 );
		$('#networkHaconTempN3').text( 				haconTempN3 );
		$('#networkHaconTempN4').text( 				haconTempN4 );
		$('#networkHaconTempN5').text( 				haconTempN5 );
			
		$('#networkHaconStatusN1').text( 				haconStatusN1 );
		$('#networkHaconStatusN2').text( 				haconStatusN2 );
		$('#networkHaconStatusN3').text( 				haconStatusN3 );
		$('#networkHaconStatusN4').text( 				haconStatusN4 );
		$('#networkHaconStatusN5').text( 				haconStatusN5 );
	
		$('#networkHaconExistN1').text( 				haconExistN1 );
		$('#networkHaconExistN2').text( 				haconExistN2 );
		$('#networkHaconExistN3').text( 				haconExistN3 );
		$('#networkHaconExistN4').text( 				haconExistN4 );
		$('#networkHaconExistN5').text( 				haconExistN5 );
		
		$('#networkTSensorTempN1').text( 				tSensorTempN1 );
		$('#networkTSensorTempN2').text( 				tSensorTempN2 );
		$('#networkTSensorTempN3').text( 				tSensorTempN3 );
		$('#networkTSensorTempN4').text( 				tSensorTempN4 );
		$('#networkTSensorTempN5').text( 				tSensorTempN5 );
			
		$('#networkTSensorStatusN1').text( 				tSensorStatusN1 );
		$('#networkTSensorStatusN2').text( 				tSensorStatusN2 );
		$('#networkTSensorStatusN3').text( 				tSensorStatusN3 );
		$('#networkTSensorStatusN4').text( 				tSensorStatusN4 );
		$('#networkTSensorStatusN5').text( 				tSensorStatusN5 );
	
		$('#networkTSensorExistN1').text( 				tSensorExistN1 );
		$('#networkTSensorExistN2').text( 				tSensorExistN2 );
		$('#networkTSensorExistN3').text( 				tSensorExistN3 );
		$('#networkTSensorExistN4').text( 				tSensorExistN4 );
		$('#networkTSensorExistN5').text( 				tSensorExistN5 );
		
		$('#networkSignStatus').text( 					signStatus );
		$('#networkSignOnOff').text( 					signOnOff );
	}
	
	
	if( userType == 4 )
	{		
		$('#signSignStatus').text( 					signStatus );
		$('#signSignOnOff').text( 					signOnOff );
	}
	
	
}

function deviceInfoCheck(info, userType)
{
	var size = info.length;
	if( info.length == 0 )
		return;
	
	
	
	if( userType == 0 )
	{
		$('#realDeviceInfoTable').append("<tr>"
				+"<th>테몬타입</th>"
				+"<th>아이디</th>"			
				+"<th>포트번호</th>"		
				+"<th>온도</th>"
				+"<th>타입</th>"
				+"<th>기기이름</th>"
				+"<th>배터리</th>"
				+"<th>RSSI</th>"
				+"<th>상태값</th>"
				+"</tr>");
		
		for(var i=0; i<size; i++)
		{		
			$('#realDeviceInfoTable').append("<tr>"
					+"<td>"+info[i].temonType +"</td>"
					+"<td>"+info[i].temonId +"</td>"
					+"<td>"+info[i].portNo +"</td>"	
					+"<td>"+info[i].deviceTemp +"</td>"
					+"<td>"+info[i].deviceType +"</td>"
					+"<td>"+info[i].deviceLoc +"</td>"
					+"<td>"+info[i].battery +"</td>"
					+"<td>"+info[i].rssi +"</td>"
					+"<td>"+info[i].deviceStatus +"</td>"
					+"</tr>");
			//$('#deviceTable').append("<tr><td>11</td><td>22</td></tr>");
		}
	}
	
	
	if( userType == 1 )
	{
		$('#elecDeviceInfoTable').append("<tr>"
				+"<th>테몬타입</th>"
				+"<th>아이디</th>"			
				+"<th>포트번호</th>"		
				+"<th>온도</th>"
				+"<th>타입</th>"
				+"<th>기기이름</th>"
				+"<th>배터리</th>"
				+"<th>RSSI</th>"
				+"<th>상태값</th>"
				+"</tr>");
		
		for(var i=0; i<size; i++)
		{		
			$('#elecDeviceInfoTable').append("<tr>"
					+"<td>"+info[i].temonType +"</td>"
					+"<td>"+info[i].temonId +"</td>"
					+"<td>"+info[i].portNo +"</td>"	
					+"<td>"+info[i].deviceTemp +"</td>"
					+"<td>"+info[i].deviceType +"</td>"
					+"<td>"+info[i].deviceLoc +"</td>"
					+"<td>"+info[i].battery +"</td>"
					+"<td>"+info[i].rssi +"</td>"
					+"<td>"+info[i].deviceStatus +"</td>"
					+"</tr>");
			//$('#deviceTable').append("<tr><td>11</td><td>22</td></tr>");
		}
	}
	
	if( userType == 2 )
	{
		$('#sensorDeviceInfoTable').append("<tr>"
				+"<th>테몬타입</th>"
				+"<th>아이디</th>"			
				+"<th>포트번호</th>"		
				+"<th>온도</th>"
				+"<th>타입</th>"
				+"<th>기기이름</th>"
				+"<th>배터리</th>"
				+"<th>RSSI</th>"
				+"<th>상태값</th>"
				+"</tr>");
		
		for(var i=0; i<size; i++)
		{		
			$('#sensorDeviceInfoTable').append("<tr>"
					+"<td>"+info[i].temonType +"</td>"
					+"<td>"+info[i].temonId +"</td>"
					+"<td>"+info[i].portNo +"</td>"	
					+"<td>"+info[i].deviceTemp +"</td>"
					+"<td>"+info[i].deviceType +"</td>"
					+"<td>"+info[i].deviceLoc +"</td>"
					+"<td>"+info[i].battery +"</td>"
					+"<td>"+info[i].rssi +"</td>"
					+"<td>"+info[i].deviceStatus +"</td>"
					+"</tr>");
			//$('#deviceTable').append("<tr><td>11</td><td>22</td></tr>");
		}
	}
	
	if( userType == 3 )
	{
		$('#networkDeviceInfoTable').append("<tr>"
				+"<th>테몬타입</th>"
				+"<th>아이디</th>"			
				+"<th>포트번호</th>"		
				+"<th>온도</th>"
				+"<th>타입</th>"
				+"<th>기기이름</th>"
				+"<th>배터리</th>"
				+"<th>RSSI</th>"
				+"<th>상태값</th>"
				+"</tr>");
		
		for(var i=0; i<size; i++)
		{		
			$('#networkDeviceInfoTable').append("<tr>"
					+"<td>"+info[i].temonType +"</td>"
					+"<td>"+info[i].temonId +"</td>"
					+"<td>"+info[i].portNo +"</td>"	
					+"<td>"+info[i].deviceTemp +"</td>"
					+"<td>"+info[i].deviceType +"</td>"
					+"<td>"+info[i].deviceLoc +"</td>"
					+"<td>"+info[i].battery +"</td>"
					+"<td>"+info[i].rssi +"</td>"
					+"<td>"+info[i].deviceStatus +"</td>"
					+"</tr>");
			//$('#deviceTable').append("<tr><td>11</td><td>22</td></tr>");
		}
	}
	
	
	
	
}




</script>

<div id="loadingArea">
	<!--  일반 정보 -->
	<div id="storeInfoDiv">
		<div>
			<span style="font-size:3em;font-bold:bold;">● 점포 정보</span>
		</div>
		
		<table id="networkIpTable">			
			<tr>
				<th>시스템코드</th>
				<td><span id="strCd">-</span></td>				
				
				<th>G/W IP</th>
				<td><span id="gwIp">-</span></td>				
			</tr>
			<tr>
				<th>점포명</th>
				<td><span id="strNm">-</span></td>
				<th>G/W NETMASK</th>
				<td><span id="gwNetmask">-</span></td>				
			</tr>
			<tr>
				<th>점포코드</th>
				<td><span id="viewStrCd">-</span></td>				
				<th>G/W GATEWAY</th>
				<td><span id="gwGateway">-</span></td>				
			</tr>
			<tr>
				<th>G/W ID</th>
				<td><span id="gwId">-</span></td>				
				<th>I/F IP</th>
				<td><span id="ifIp">-</span></td>				
			</tr>
			<tr>
				<th>G/W MAC</th>
				<td><span id="mac">-</span></td>
				<th>I/F PORT</th>
				<td><span id="ifPort">-</span></td>				
			</tr>
			
		</table>
	</div>
	
	
	
	<!-- 리얼 데이터 정보 -->
	<div id="realInfoDiv">
		
		<div>
			<span style="font-size:3em;font-bold:bold;">● 실 수집 데이터</span>
		</div>
		<div style="width:49.5%;display:inline-block">
		
			
			
			<table id="realInfoTable">
				<tr>
					<th class="title" colspan="4" style="text-align:center;">
						전력 Info
					</th>
				</tr>
				<tr>
					<th>채널</th>
					<th>누적전력</th>
					<th>순시전력</th>
					<th>상태</th>
				</tr>
				<tr>
					<th>1 CH</th>				
					<td><span id="realEp1chAcc">-</span></td>
					<td><span id="realEp1chInst">-</span></td>
					<td><span id="realEp1chStatus">-</span></td>
				</tr>
				<tr>
					<th>2 CH</th>				
					<td><span id="realEp2chAcc">-</span></td>
					<td><span id="realEp2chInst">-</span></td>
					<td><span id="realEp2chStatus">-</span></td>
				</tr>
				<tr>
					<th>3 CH</th>				
					<td><span id="realEp3chAcc">-</span></td>
					<td><span id="realEp3chInst">-</span></td>
					<td><span id="realEp3chStatus">-</span></td>
				</tr>
				<tr>
					<th>4 CH</th>				
					<td><span id="realEp4chAcc">-</span></td>
					<td><span id="realEp4chInst">-</span></td>
					<td><span id="realEp4chStatus">-</span></td>
				</tr>
				<tr>
					<th>5 CH</th>				
					<td><span id="realEp5chAcc">-</span></td>
					<td><span id="realEp5chInst">-</span></td>
					<td><span id="realEp5chStatus">-</span></td>
				</tr>
				<tr>
					<th>6 CH</th>				
					<td><span id="realEp6chAcc">-</span></td>
					<td><span id="realEp6chInst">-</span></td>
					<td><span id="realEp6chStatus">-</span></td>
				</tr>
				<tr>
					<th>7R CH</th>				
					<td><span id="realEp7chRAcc">-</span></td>
					<td><span id="realEp7chRInst">-</span></td>
					<td><span id="realEp7chRStatus">-</span></td>
				</tr>
				<tr>
					<th>7S CH</th>				
					<td><span id="realEp7chSAcc">-</span></td>
					<td><span id="realEp7chSInst">-</span></td>
					<td><span id="realEp7chSStatus">-</span></td>
				</tr>
				<tr>
					<th>7T CH</th>				
					<td><span id="realEp7chTAcc">-</span></td>
					<td><span id="realEp7chTInst">-</span></td>
					<td><span id="realEp7chTStatus">-</span></td>
				</tr>
				<tr>
					<th>8R CH</th>				
					<td><span id="realEp8chRAcc">-</span></td>
					<td><span id="realEp8chRInst">-</span></td>
					<td><span id="realEp8chRStatus">-</span></td>
				</tr>
				<tr>
					<th>8S CH</th>				
					<td><span id="realEp8chSAcc">-</span></td>
					<td><span id="realEp8chSInst">-</span></td>
					<td><span id="realEp8chSStatus">-</span></td>
				</tr>
				<tr>
					<th>8T CH</th>				
					<td><span id="realEp8chTAcc">-</span></td>
					<td><span id="realEp8chTInst">-</span></td>
					<td><span id="realEp8chTStatus">-</span></td>
				</tr>
				<tr>
					<th>채널 개수</th>				
					<td colspan="3"><span id="realChannelCnt">-</span></td>					
				</tr>
				<tr>
					<th>RST 체크</th>				
					<td colspan="3"><span id="realRST">-</span></td>					
				</tr>
			</table>
		</div>
		
		<div style="width:49.5%;display:inline-block;">
			<table>
				<tr>
					<th class="title" colspan="4" style="text-align:center;">
						하콘 Info
					</th>
				</tr>
				<tr>
					<th>No</th>
					<th>온도</th>
					<th>상태값</th>
					<th>Exist</th>
				</tr>
				<tr>
					<th>1</th>
					<td><span id="realHaconTempN1">-</span></td>
					<td><span id="realHaconStatusN1">-</span></td>
					<td><span id="realHaconExistN1">-</span></td>								
				</tr>
				<tr>
					<th>2</th>
					<td><span id="realHaconTempN2">-</span></td>
					<td><span id="realHaconStatusN2">-</span></td>
					<td><span id="realHaconExistN2">-</span></td>								
				</tr>
				<tr>
					<th>3</th>
					<td><span id="realHaconTempN3">-</span></td>
					<td><span id="realHaconStatusN3">-</span></td>
					<td><span id="realHaconExistN3">-</span></td>								
				</tr>
				<tr>
					<th>4</th>
					<td><span id="realHaconTempN4">-</span></td>
					<td><span id="realHaconStatusN4">-</span></td>
					<td><span id="realHaconExistN4">-</span></td>								
				</tr>
				<tr>
					<th>5</th>
					<td><span id="realHaconTempN5">-</span></td>
					<td><span id="realHaconStatusN5">-</span></td>
					<td><span id="realHaconExistN5">-</span></td>								
				</tr>
				<tr>
					<th class="title" colspan="4" style="text-align:center;">
						티센서 Info
					</th>
				</tr>
				<tr>
					<th>No</th>
					<th>온도</th>
					<th>상태값</th>
					<th>Exist</th>
				</tr>
				<tr>
					<th>1</th>
					<td><span id="realTSensorTempN1">-</span></td>
					<td><span id="realTSensorStatusN1">-</span></td>
					<td><span id="realTSensorExistN1">-</span></td>								
				</tr>
				<tr>
					<th>2</th>
					<td><span id="realTSensorTempN2">-</span></td>
					<td><span id="realTSensorStatusN2">-</span></td>
					<td><span id="realTSensorExistN2">-</span></td>								
				</tr>
				<tr>
					<th>3</th>
					<td><span id="realTSensorTempN3">-</span></td>
					<td><span id="realTSensorStatusN3">-</span></td>
					<td><span id="realTSensorExistN3">-</span></td>								
				</tr>
				<tr>
					<th>4</th>
					<td><span id="realTSensorTempN4">-</span></td>
					<td><span id="realTSensorStatusN4">-</span></td>
					<td><span id="realTSensorExistN4">-</span></td>								
				</tr>
				<tr>
					<th>5</th>
					<td><span id="realTSensorTempN5">-</span></td>
					<td><span id="realTSensorStatusN5">-</span></td>
					<td><span id="realTSensorExistN5">-</span></td>								
				</tr>
				
				<tr>
					<th class="title" colspan="4" style="text-align:center;">
						간판 Info
					</th>
				</tr>
				<tr>
					<th>상태</th>
					<td><span id="realSignStatus">-</span></td>
					<th>ONOFF</th>
					<td><span id="realSignOnOff">-</span></td>								
				</tr>
				
			</table>
		</div>
		
		
		<div>
			<table id="realDeviceInfoTable">
				<tr>
					<th class="title" colspan="9" style="text-align:center;">
							테몬,지그비 Info
					</th>
				</tr>
			</table>
		</div>
	</div>
	
	
	
	
	<!-- 전기 업체 정보 -->
	<div id="elecInfoDiv">
		
		<div>
			<span style="font-size:3em;font-bold:bold;">● 전기 업체 체크리스트</span>
		</div>
		<div style="width:49.5%;display:inline-block">
		
			
			<table id="elecInfoTable">
				<tr>
					<th class="title" colspan="4" style="text-align:center;">
						전력 Info
					</th>
				</tr>
				<tr>
					<th>채널</th>
					<th>누적전력</th>
					<th>순시전력</th>
					<th>상태</th>
				</tr>
				<tr>
					<th>1 CH</th>				
					<td><span id="elecEp1chAcc">-</span></td>
					<td><span id="elecEp1chInst">-</span></td>
					<td><span id="elecEp1chStatus">-</span></td>
				</tr>
				<tr>
					<th>2 CH</th>				
					<td><span id="elecEp2chAcc">-</span></td>
					<td><span id="elecEp2chInst">-</span></td>
					<td><span id="elecEp2chStatus">-</span></td>
				</tr>
				<tr>
					<th>3 CH</th>				
					<td><span id="elecEp3chAcc">-</span></td>
					<td><span id="elecEp3chInst">-</span></td>
					<td><span id="elecEp3chStatus">-</span></td>
				</tr>
				<tr>
					<th>4 CH</th>				
					<td><span id="elecEp4chAcc">-</span></td>
					<td><span id="elecEp4chInst">-</span></td>
					<td><span id="elecEp4chStatus">-</span></td>
				</tr>
				<tr>
					<th>5 CH</th>				
					<td><span id="elecEp5chAcc">-</span></td>
					<td><span id="elecEp5chInst">-</span></td>
					<td><span id="elecEp5chStatus">-</span></td>
				</tr>
				<tr>
					<th>6 CH</th>				
					<td><span id="elecEp6chAcc">-</span></td>
					<td><span id="elecEp6chInst">-</span></td>
					<td><span id="elecEp6chStatus">-</span></td>
				</tr>
				<tr>
					<th>7R CH</th>				
					<td><span id="elecEp7chRAcc">-</span></td>
					<td><span id="elecEp7chRInst">-</span></td>
					<td><span id="elecEp7chRStatus">-</span></td>
				</tr>
				<tr>
					<th>7S CH</th>				
					<td><span id="elecEp7chSAcc">-</span></td>
					<td><span id="elecEp7chSInst">-</span></td>
					<td><span id="elecEp7chSStatus">-</span></td>
				</tr>
				<tr>
					<th>7T CH</th>				
					<td><span id="elecEp7chTAcc">-</span></td>
					<td><span id="elecEp7chTInst">-</span></td>
					<td><span id="elecEp7chTStatus">-</span></td>
				</tr>
				<tr>
					<th>8R CH</th>				
					<td><span id="elecEp8chRAcc">-</span></td>
					<td><span id="elecEp8chRInst">-</span></td>
					<td><span id="elecEp8chRStatus">-</span></td>
				</tr>
				<tr>
					<th>8S CH</th>				
					<td><span id="elecEp8chSAcc">-</span></td>
					<td><span id="elecEp8chSInst">-</span></td>
					<td><span id="elecEp8chSStatus">-</span></td>
				</tr>
				<tr>
					<th>8T CH</th>				
					<td><span id="elecEp8chTAcc">-</span></td>
					<td><span id="elecEp8chTInst">-</span></td>
					<td><span id="elecEp8chTStatus">-</span></td>
				</tr>
				
				<tr>
					<th>채널 개수</th>				
					<td colspan="3"><span id="elecChannelCnt">-</span></td>					
				</tr>
				<tr>
					<th>RST 체크</th>				
					<td colspan="3"><span id="elecRST">-</span></td>					
				</tr>
				
			</table>
		</div>
		
		<div style="width:49.5%;display:inline-block;">
			<table>
				<tr>
					<th class="title" colspan="4" style="text-align:center;">
						하콘 Info
					</th>
				</tr>
				<tr>
					<th>No</th>
					<th>온도</th>
					<th>상태값</th>
					<th>Exist</th>
				</tr>
				<tr>
					<th>1</th>
					<td><span id="elecHaconTempN1">-</span></td>
					<td><span id="elecHaconStatusN1">-</span></td>
					<td><span id="elecHaconExistN1">-</span></td>								
				</tr>
				<tr>
					<th>2</th>
					<td><span id="elecHaconTempN2">-</span></td>
					<td><span id="elecHaconStatusN2">-</span></td>
					<td><span id="elecHaconExistN2">-</span></td>								
				</tr>
				<tr>
					<th>3</th>
					<td><span id="elecHaconTempN3">-</span></td>
					<td><span id="elecHaconStatusN3">-</span></td>
					<td><span id="elecHaconExistN3">-</span></td>								
				</tr>
				<tr>
					<th>4</th>
					<td><span id="elecHaconTempN4">-</span></td>
					<td><span id="elecHaconStatusN4">-</span></td>
					<td><span id="elecHaconExistN4">-</span></td>								
				</tr>
				<tr>
					<th>5</th>
					<td><span id="elecHaconTempN5">-</span></td>
					<td><span id="elecHaconStatusN5">-</span></td>
					<td><span id="elecHaconExistN5">-</span></td>								
				</tr>
				<tr>
					<th class="title" colspan="4" style="text-align:center;">
						티센서 Info
					</th>
				</tr>
				<tr>
					<th>No</th>
					<th>온도</th>
					<th>상태값</th>
					<th>Exist</th>
				</tr>
				<tr>
					<th>1</th>
					<td><span id="elecTSensorTempN1">-</span></td>
					<td><span id="elecTSensorStatusN1">-</span></td>
					<td><span id="elecTSensorExistN1">-</span></td>								
				</tr>
				<tr>
					<th>2</th>
					<td><span id="elecTSensorTempN2">-</span></td>
					<td><span id="elecTSensorStatusN2">-</span></td>
					<td><span id="elecTSensorExistN2">-</span></td>								
				</tr>
				<tr>
					<th>3</th>
					<td><span id="elecTSensorTempN3">-</span></td>
					<td><span id="elecTSensorStatusN3">-</span></td>
					<td><span id="elecTSensorExistN3">-</span></td>								
				</tr>
				<tr>
					<th>4</th>
					<td><span id="elecTSensorTempN4">-</span></td>
					<td><span id="elecTSensorStatusN4">-</span></td>
					<td><span id="elecTSensorExistN4">-</span></td>								
				</tr>
				<tr>
					<th>5</th>
					<td><span id="elecTSensorTempN5">-</span></td>
					<td><span id="elecTSensorStatusN5">-</span></td>
					<td><span id="elecTSensorExistN5">-</span></td>								
				</tr>
				
				<tr>
					<th class="title" colspan="4" style="text-align:center;">
						간판 Info
					</th>
				</tr>
				<tr>
					<th>상태</th>
					<td><span id="elecSignStatus">-</span></td>
					<th>ONOFF</th>
					<td><span id="elecSignOnOff">-</span></td>								
				</tr>
				
			</table>
		</div>
		
		
		<div>
			<table id="elecDeviceInfoTable">
				<tr>
					<th class="title" colspan="9" style="text-align:center;">
							테몬,지그비 Info
					</th>
				</tr>
			</table>
		</div>		
		
	</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<br><br>
	<!-- 유지보수 업체 정보 -->
	<div id="sensorInfoDiv">
		
		<div>
			<span style="font-size:3em;font-bold:bold;">● 유지보수 업체 체크리스트</span>
		</div>
		<div style="width:49.5%;display:inline-block">
		
			
			<table id="sensorInfoTable">
				<tr>
					<th class="title" colspan="4" style="text-align:center;">
						전력 Info
					</th>
				</tr>
				<tr>
					<th>채널</th>
					<th>누적전력</th>
					<th>순시전력</th>
					<th>상태</th>
				</tr>
				<tr>
					<th>1 CH</th>				
					<td><span id="sensorEp1chAcc">-</span></td>
					<td><span id="sensorEp1chInst">-</span></td>
					<td><span id="sensorEp1chStatus">-</span></td>
				</tr>
				<tr>
					<th>2 CH</th>				
					<td><span id="sensorEp2chAcc">-</span></td>
					<td><span id="sensorEp2chInst">-</span></td>
					<td><span id="sensorEp2chStatus">-</span></td>
				</tr>
				<tr>
					<th>3 CH</th>				
					<td><span id="sensorEp3chAcc">-</span></td>
					<td><span id="sensorEp3chInst">-</span></td>
					<td><span id="sensorEp3chStatus">-</span></td>
				</tr>
				<tr>
					<th>4 CH</th>				
					<td><span id="sensorEp4chAcc">-</span></td>
					<td><span id="sensorEp4chInst">-</span></td>
					<td><span id="sensorEp4chStatus">-</span></td>
				</tr>
				<tr>
					<th>5 CH</th>				
					<td><span id="sensorEp5chAcc">-</span></td>
					<td><span id="sensorEp5chInst">-</span></td>
					<td><span id="sensorEp5chStatus">-</span></td>
				</tr>
				<tr>
					<th>6 CH</th>				
					<td><span id="sensorEp6chAcc">-</span></td>
					<td><span id="sensorEp6chInst">-</span></td>
					<td><span id="sensorEp6chStatus">-</span></td>
				</tr>
				<tr>
					<th>7R CH</th>				
					<td><span id="sensorEp7chRAcc">-</span></td>
					<td><span id="sensorEp7chRInst">-</span></td>
					<td><span id="sensorEp7chRStatus">-</span></td>
				</tr>
				<tr>
					<th>7S CH</th>				
					<td><span id="sensorEp7chSAcc">-</span></td>
					<td><span id="sensorEp7chSInst">-</span></td>
					<td><span id="sensorEp7chSStatus">-</span></td>
				</tr>
				<tr>
					<th>7T CH</th>				
					<td><span id="sensorEp7chTAcc">-</span></td>
					<td><span id="sensorEp7chTInst">-</span></td>
					<td><span id="sensorEp7chTStatus">-</span></td>
				</tr>
				<tr>
					<th>8R CH</th>				
					<td><span id="sensorEp8chRAcc">-</span></td>
					<td><span id="sensorEp8chRInst">-</span></td>
					<td><span id="sensorEp8chRStatus">-</span></td>
				</tr>
				<tr>
					<th>8S CH</th>				
					<td><span id="sensorEp8chSAcc">-</span></td>
					<td><span id="sensorEp8chSInst">-</span></td>
					<td><span id="sensorEp8chSStatus">-</span></td>
				</tr>
				<tr>
					<th>8T CH</th>				
					<td><span id="sensorEp8chTAcc">-</span></td>
					<td><span id="sensorEp8chTInst">-</span></td>
					<td><span id="sensorEp8chTStatus">-</span></td>
				</tr>
				
				<tr>
					<th>채널 개수</th>				
					<td colspan="3"><span id="sensorChannelCnt">-</span></td>					
				</tr>
				<tr>
					<th>RST 체크</th>				
					<td colspan="3"><span id="sensorRST">-</span></td>					
				</tr>
				
			</table>
		</div>
		
		<div style="width:49.5%;display:inline-block;">
			<table>
				<tr>
					<th class="title" colspan="4" style="text-align:center;">
						하콘 Info
					</th>
				</tr>
				<tr>
					<th>No</th>
					<th>온도</th>
					<th>상태값</th>
					<th>Exist</th>
				</tr>
				<tr>
					<th>1</th>
					<td><span id="sensorHaconTempN1">-</span></td>
					<td><span id="sensorHaconStatusN1">-</span></td>
					<td><span id="sensorHaconExistN1">-</span></td>								
				</tr>
				<tr>
					<th>2</th>
					<td><span id="sensorHaconTempN2">-</span></td>
					<td><span id="sensorHaconStatusN2">-</span></td>
					<td><span id="sensorHaconExistN2">-</span></td>								
				</tr>
				<tr>
					<th>3</th>
					<td><span id="sensorHaconTempN3">-</span></td>
					<td><span id="sensorHaconStatusN3">-</span></td>
					<td><span id="sensorHaconExistN3">-</span></td>								
				</tr>
				<tr>
					<th>4</th>
					<td><span id="sensorHaconTempN4">-</span></td>
					<td><span id="sensorHaconStatusN4">-</span></td>
					<td><span id="sensorHaconExistN4">-</span></td>								
				</tr>
				<tr>
					<th>5</th>
					<td><span id="sensorHaconTempN5">-</span></td>
					<td><span id="sensorHaconStatusN5">-</span></td>
					<td><span id="sensorHaconExistN5">-</span></td>								
				</tr>
				<tr>
					<th class="title" colspan="4" style="text-align:center;">
						티센서 Info
					</th>
				</tr>
				<tr>
					<th>No</th>
					<th>온도</th>
					<th>상태값</th>
					<th>Exist</th>
				</tr>
				<tr>
					<th>1</th>
					<td><span id="sensorTSensorTempN1">-</span></td>
					<td><span id="sensorTSensorStatusN1">-</span></td>
					<td><span id="sensorTSensorExistN1">-</span></td>								
				</tr>
				<tr>
					<th>2</th>
					<td><span id="sensorTSensorTempN2">-</span></td>
					<td><span id="sensorTSensorStatusN2">-</span></td>
					<td><span id="sensorTSensorExistN2">-</span></td>								
				</tr>
				<tr>
					<th>3</th>
					<td><span id="sensorTSensorTempN3">-</span></td>
					<td><span id="sensorTSensorStatusN3">-</span></td>
					<td><span id="sensorTSensorExistN3">-</span></td>								
				</tr>
				<tr>
					<th>4</th>
					<td><span id="sensorTSensorTempN4">-</span></td>
					<td><span id="sensorTSensorStatusN4">-</span></td>
					<td><span id="sensorTSensorExistN4">-</span></td>								
				</tr>
				<tr>
					<th>5</th>
					<td><span id="sensorTSensorTempN5">-</span></td>
					<td><span id="sensorTSensorStatusN5">-</span></td>
					<td><span id="sensorTSensorExistN5">-</span></td>								
				</tr>
				
				<tr>
					<th class="title" colspan="4" style="text-align:center;">
						간판 Info
					</th>
				</tr>
				<tr>
					<th>상태</th>
					<td><span id="sensorSignStatus">-</span></td>
					<th>ONOFF</th>
					<td><span id="sensorSignOnOff">-</span></td>								
				</tr>
				
			</table>
		</div>
		
		
		<div>
			<table id="sensorDeviceInfoTable">
				<tr>
					<th class="title" colspan="9" style="text-align:center;">
							테몬,지그비 Info
					</th>
				</tr>
			</table>
		</div>
		
		
	</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	<br><br>
	<!-- 네트워크 업체 정보 -->
	<div id="networkInfoDiv">
		
		<div>
			<span style="font-size:3em;font-bold:bold;">● 네트워크 체크리스트</span>
		</div>
		<div style="width:49.5%;display:inline-block">
		
			
			<table id="networkInfoTable">
				<tr>
					<th class="title" colspan="4" style="text-align:center;">
						전력 Info
					</th>
				</tr>
				<tr>
					<th>채널</th>
					<th>누적전력</th>
					<th>순시전력</th>
					<th>상태</th>
				</tr>
				<tr>
					<th>1 CH</th>				
					<td><span id="networkEp1chAcc">-</span></td>
					<td><span id="networkEp1chInst">-</span></td>
					<td><span id="networkEp1chStatus">-</span></td>
				</tr>
				<tr>
					<th>2 CH</th>				
					<td><span id="networkEp2chAcc">-</span></td>
					<td><span id="networkEp2chInst">-</span></td>
					<td><span id="networkEp2chStatus">-</span></td>
				</tr>
				<tr>
					<th>3 CH</th>				
					<td><span id="networkEp3chAcc">-</span></td>
					<td><span id="networkEp3chInst">-</span></td>
					<td><span id="networkEp3chStatus">-</span></td>
				</tr>
				<tr>
					<th>4 CH</th>				
					<td><span id="networkEp4chAcc">-</span></td>
					<td><span id="networkEp4chInst">-</span></td>
					<td><span id="networkEp4chStatus">-</span></td>
				</tr>
				<tr>
					<th>5 CH</th>				
					<td><span id="networkEp5chAcc">-</span></td>
					<td><span id="networkEp5chInst">-</span></td>
					<td><span id="networkEp5chStatus">-</span></td>
				</tr>
				<tr>
					<th>6 CH</th>				
					<td><span id="networkEp6chAcc">-</span></td>
					<td><span id="networkEp6chInst">-</span></td>
					<td><span id="networkEp6chStatus">-</span></td>
				</tr>
				<tr>
					<th>7R CH</th>				
					<td><span id="networkEp7chRAcc">-</span></td>
					<td><span id="networkEp7chRInst">-</span></td>
					<td><span id="networkEp7chRStatus">-</span></td>
				</tr>
				<tr>
					<th>7S CH</th>				
					<td><span id="networkEp7chSAcc">-</span></td>
					<td><span id="networkEp7chSInst">-</span></td>
					<td><span id="networkEp7chSStatus">-</span></td>
				</tr>
				<tr>
					<th>7T CH</th>				
					<td><span id="networkEp7chTAcc">-</span></td>
					<td><span id="networkEp7chTInst">-</span></td>
					<td><span id="networkEp7chTStatus">-</span></td>
				</tr>
				<tr>
					<th>8R CH</th>				
					<td><span id="networkEp8chRAcc">-</span></td>
					<td><span id="networkEp8chRInst">-</span></td>
					<td><span id="networkEp8chRStatus">-</span></td>
				</tr>
				<tr>
					<th>8S CH</th>				
					<td><span id="networkEp8chSAcc">-</span></td>
					<td><span id="networkEp8chSInst">-</span></td>
					<td><span id="networkEp8chSStatus">-</span></td>
				</tr>
				<tr>
					<th>8T CH</th>				
					<td><span id="networkEp8chTAcc">-</span></td>
					<td><span id="networkEp8chTInst">-</span></td>
					<td><span id="networkEp8chTStatus">-</span></td>
				</tr>
				
				<tr>
					<th>채널 개수</th>				
					<td colspan="3"><span id="networkChannelCnt">-</span></td>					
				</tr>
				<tr>
					<th>RST 체크</th>				
					<td colspan="3"><span id="networkRST">-</span></td>					
				</tr>
				
			</table>
		</div>
		
		<div style="width:49.5%;display:inline-block;">
			<table>
				<tr>
					<th class="title" colspan="4" style="text-align:center;">
						하콘 Info
					</th>
				</tr>
				<tr>
					<th>No</th>
					<th>온도</th>
					<th>상태값</th>
					<th>Exist</th>
				</tr>
				<tr>
					<th>1</th>
					<td><span id="networkHaconTempN1">-</span></td>
					<td><span id="networkHaconStatusN1">-</span></td>
					<td><span id="networkHaconExistN1">-</span></td>								
				</tr>
				<tr>
					<th>2</th>
					<td><span id="networkHaconTempN2">-</span></td>
					<td><span id="networkHaconStatusN2">-</span></td>
					<td><span id="networkHaconExistN2">-</span></td>								
				</tr>
				<tr>
					<th>3</th>
					<td><span id="networkHaconTempN3">-</span></td>
					<td><span id="networkHaconStatusN3">-</span></td>
					<td><span id="networkHaconExistN3">-</span></td>								
				</tr>
				<tr>
					<th>4</th>
					<td><span id="networkHaconTempN4">-</span></td>
					<td><span id="networkHaconStatusN4">-</span></td>
					<td><span id="networkHaconExistN4">-</span></td>								
				</tr>
				<tr>
					<th>5</th>
					<td><span id="networkHaconTempN5">-</span></td>
					<td><span id="networkHaconStatusN5">-</span></td>
					<td><span id="networkHaconExistN5">-</span></td>								
				</tr>
				<tr>
					<th class="title" colspan="4" style="text-align:center;">
						티센서 Info
					</th>
				</tr>
				<tr>
					<th>No</th>
					<th>온도</th>
					<th>상태값</th>
					<th>Exist</th>
				</tr>
				<tr>
					<th>1</th>
					<td><span id="networkTSensorTempN1">-</span></td>
					<td><span id="networkTSensorStatusN1">-</span></td>
					<td><span id="networkTSensorExistN1">-</span></td>								
				</tr>
				<tr>
					<th>2</th>
					<td><span id="networkTSensorTempN2">-</span></td>
					<td><span id="networkTSensorStatusN2">-</span></td>
					<td><span id="networkTSensorExistN2">-</span></td>								
				</tr>
				<tr>
					<th>3</th>
					<td><span id="networkTSensorTempN3">-</span></td>
					<td><span id="networkTSensorStatusN3">-</span></td>
					<td><span id="networkTSensorExistN3">-</span></td>								
				</tr>
				<tr>
					<th>4</th>
					<td><span id="networkTSensorTempN4">-</span></td>
					<td><span id="networkTSensorStatusN4">-</span></td>
					<td><span id="networkTSensorExistN4">-</span></td>								
				</tr>
				<tr>
					<th>5</th>
					<td><span id="networkTSensorTempN5">-</span></td>
					<td><span id="networkTSensorStatusN5">-</span></td>
					<td><span id="networkTSensorExistN5">-</span></td>								
				</tr>
				
				<tr>
					<th class="title" colspan="4" style="text-align:center;">
						간판 Info
					</th>
				</tr>
				<tr>
					<th>상태</th>
					<td><span id="networkSignStatus">-</span></td>
					<th>ONOFF</th>
					<td><span id="networkSignOnOff">-</span></td>								
				</tr>
				
			</table>
		</div>
		
		
		<div>
			<table id="networkDeviceInfoTable">
				<tr>
					<th class="title" colspan="9" style="text-align:center;">
							테몬,지그비 Info
					</th>
				</tr>
			</table>
		</div>
		
		
	</div>
	
	
	
	
	<br><br>
	<!-- 네트워크 업체 정보 -->
	<div id="signInfoDiv">
		
		<div>
			<span style="font-size:3em;font-bold:bold;">● 간판 업체 체크리스트</span>
		</div>
		
		
		<div>
			<table>
				<tr>
					<th class="title" colspan="4" style="text-align:center;">
						간판 Info
					</th>
				</tr>
				<tr>
					<td>상태</td>
					<td><span id="signSignStatus">-</span></td>
					<td>ONOFF</td>
					<td><span id="signSignOnOff">-</span></td>								
				</tr>
				
			</table>
		</div>
		
		
		
		
	</div>
	
</div>
