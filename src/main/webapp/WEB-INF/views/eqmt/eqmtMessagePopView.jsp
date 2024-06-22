<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="smSeq"><spring:message code="seq"/></c:set>
<c:set var="smSelect"><spring:message code="select"/></c:set>
<c:set var="smOrg"><spring:message code="org"/></c:set>
<c:set var="smStrCd"><spring:message code="strCd" /></c:set>
<c:set var="smStrNm"><spring:message code="strNm" /></c:set>
<c:set var="smStr"><spring:message code="str" /></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>
<c:set var="smCnfm"><spring:message code="cnfm" /></c:set>
<c:set var="smClos"><spring:message code="clos" /></c:set>
<c:set var="smStrInq"><spring:message code="strInq" /></c:set>

<script type="text/javascript">

/*******************
1. 선행, 등록 스크립트
********************/
var rowKey = 1;
var page = 1;
$(document).ready(function(){
	
	$('#dialog-confirm').css('overflow', 'hidden');	
	
	var mode = '${param.mode}';
	console.log( "mode : " + mode );
	$('#popMode').val( 		'${param.mode}' 	);
	$('#popStrCd').val( 		'${param.strCd}' 	);
	$('#popTemonId').val( 		'${param.temonId}' 	);
	$('#popTemonType').val( 	'${param.temonType}');
	$('#popPortNo').val( 		'${param.portNo}' 	);
	$('#popYyyymmdd').val( 	'${param.yyyymmdd}' );
	$('#popHhmin').val( 		'${param.hhmin}' 	);
	
	
	var strCd = 	$('#popStrCd').val();
	var temonId = 	$('#popTemonId').val();
	var temonType = $('#popTemonType').val();
	var portNo = 	$('#popPortNo').val();
	
	console.log( strCd );
	
	var param  = new Object();
	param.strCd = 			strCd;
	param.yyyymmdd = 		'${param.yyyymmdd}';
	param.hhmin = 			'${param.hhmin}';
	param.temonId = 		temonId;
	param.temonType = 		temonType;
	param.portNo = 			portNo;	

	
	rowKey = getSelectedRow();								// 선택된 리스트 rowKey
	page = getSelectedPage();
		
	$.ajax({
		url:'/retrieveEqmtAlarmAsResult',
		type:'POST',
		cache:false,
		data : param,
		dataType:'json',
		success:function(data){
		
			
			var temp =  data.alarmMessage;
			var alarmMessage = temp.split("<");
			
			console.log( data );			
			$('#popStrNm').val( 			data.strNm );			// 매장명
			$('#popViewStrCd').val( 		data.viewStrCd );		// 매장코드
			$('#popAsResult').val( 		data.asResult );			// 조치/미조치
			
			console.log('222');
			$('#popAsNote').val( 			data.asNote );			// AS 조치내용			
			console.log( data.asNote );
			$('#popAddr').text( 			data.addr );			// 주소
			$('#popTelNo').val( 			data.telNo );			// 전화번호
			$('#popDeviceLoc').val( 		data.deviceLoc );		// 장비명
			$('#popAlarmDateS').val(		data.alarmDateS );		// 첫알람일시
			$('#popAlarmDateE').val( 		data.alarmDateE );		// 마지막알람일시
			$('#popAsEngineer').val( 		data.asEngineer );		// as엔지니어명
			$(':radio[name="popAsMethod"]:radio[value="'+data.asMethod+'"]').attr('checked', true);	// as처리유형
			$('#popAlarmMessage').text( 	alarmMessage[0] );	// 알람내용
			
			if( mode == "INPUT" )									// 조치내용 입력
			{
				$('#popAsEngineer').val( '${param.userNm}' );		
				$('#popAsEngineer').attr( 	"readonly","readonly" );
			}	
			if( mode == "MODIFY" )									// 조치내용 수정
			{				
				$('#popAsEngineer').attr( 	"readonly","readonly" );
			}	
			if( mode == "SEARCH" )									// 조치내용 조회
			{				
				$('#popAsEngineer').attr( 	"readonly","readonly" );
				$('#popAsNote').attr( 		"readonly","readonly" );
				$(':radio[name="popAsMethod"]:not(:checked)').attr("disabled", "disabled");
				$('#btnDiv').hide();	// 닫기 버튼 숨기기				
			}
			
		},
		error:function(result){
			alert("에러가 발생했습니다.11");
			menuLoadImgHide("loadingArea");		// 로딩바 END
			fncCancel();
		}
	});
	
	
	$('#saveForm').validate({
		ignore: "input[type='text']:hidden",
		rules:{
			popAsNote:{required:true},
			popAsMethod:{required:true},
			popAsEngineer:{required:true}			
		},			
		showErrors: function(errorMap, errorList) {	          
	          $.each(this.validElements(), function (index, element) {
	              var $element = $(element);
	              $element.data("title", "").removeClass("error").tooltip("destroy");
	          });
	          $.each(errorList, function (index, error) {
	              var $element = $(error.element);
	              $element.tooltip("destroy").data("title", error.message).addClass("error").tooltip();
	          });
	      }
	});
	
	
});


// 저장 버튼
function fncSave() 
{	
	if($('#saveForm').valid())
	{		
		if(confirm('저장하시겠습니까?'))
		{	
				
			$.ajax({
				url: '/retrieveAsResultYn',
				type:'POST',
				cache:false,
				data:$('#saveForm').serialize(),
				dataType:'json',
				success:function(data){
					
					var asResult_current = $('#popAsResult').val();
					var asResult_after = data;
					
					if( asResult_current == "N" )
					{	
						if( asResult_after == "1")
						{
							alert('이미 처리된 내역입니다.');
							return;
						}
					}

					var target = '/saveEqmtAlarmAsResult';
						$.ajax({
							url: target,
							type:'POST',
							cache:false,
							data:$('#saveForm').serialize(),
							dataType:'json',
							success:function(data){
								alert('저장되었습니다.');
								
								
								
								var list = $("#gridStoreMgnt").getRowData(rowKey);		// 선택된 리스트 정보
													
								$("#gridStoreMgnt").clearGridData();
								$("#gridStoreMgnt").setGridParam({ page: page }).trigger("reloadGrid");
								
								console.log( rowKey );
								$('#gridStoreMgnt').jqGrid('setSelection', 3);
								
								
								
							},
							error:function(result){
								alert('에러가 발생하였습니다.');
							}				
						});						
					
				},
				error:function(result){					
					alert('오류가 발생하였습니다.');
				}				
			});
			
			
			
			
		}
	}
	else
	{
		alert('필수입력란을 확인하세요.');
	}
}

// 닫기 버튼
function fncCancel() 
{
	fncDivPop1Close();
	$('#gridStoreMgnt').jqGrid('setSelection', rowKey);
			
}
</script>
<div class="r_popup">
	
	<div class="r_popupCont">
	
		<!-- 테이블 영역 -->
	
		<div class="r_inputTbl r_horizonTbl">
			<form id="saveForm" name="saveForm" method="post">
				<input type="hidden" id="popMode" 		name="popMode"		value=""/>	
				<input type="hidden" id="popStrCd" 		name="popStrCd"		value=""/>
				<input type="hidden" id="popTemonId" 	name="popTemonId"	value=""/>
				<input type="hidden" id="popTemonType" 	name="popTemonType"	value=""/>
				<input type="hidden" id="popPortNo" 	name="popPortNo"	value=""/>
				<input type="hidden" id="popYyyymmdd" 	name="popYyyymmdd"	value=""/>
				<input type="hidden" id="popHhmin" 		name="popHhmin"		value=""/>
				<input type="hidden" id="popAsResult" 	name="popAsResult"		value=""/>
				
							
				<!-- 테이블 1단 -->
				<table>
			    	<col width="17%" />
			    	<col width="31%" />
			    	<col width="17%" />
			    	<col />
			    	<tbody>
						<tr>
			         		<th>매장명</th>
			         		<td class="tleft">
			         			<input class="readonlyWhite" id="popStrNm" name="popStrNm" value="" style="width:100%; border:0px;" readonly/>
			         		</td>	
							<th>매장코드</th>
			         		<td class="tleft">
			         			<input class="readonlyWhite" id="popViewStrCd" name="popViewStrCd" value="" style="width:100%; border:0px;" readonly/>
			         		</td>
						</tr>
						<tr>
			         		<th>주소</th>
			         		<td id="popAddr" class="tleft">			         			
			         		</td>
							<th>전화번호</th>
			         		<td class="tleft">
			         			<input class="readonlyWhite" id="popTelNo" name="popTelNo" value="" style="width:100%; border:0px;" readonly/>
			         		</td>
						</tr>
					</tbody>
				</table>
				<!-- //테이블 1단 -->
				
				<!-- 테이블 2단 -->
				<table class="mt_5">	
			    	<col width="17%" />
			    	<col width="31%" />
			    	<col width="17%" />
			    	<col />
			    	<tbody>
			       		<tr>
			         		<th >장비명</th>
			         		<td colspan="3" class="tleft">
			         			<input class="readonlyWhite" id="popDeviceLoc"  name="popDeviceLoc" type="text" value="" style="width:100%;" readonly/>
			         		</td>
						</tr>
						<tr>
			         		<th> 알람시작기간</th>
			         		<td class="tleft">
			         			<input class="readonlyWhite" id="popAlarmDateS" name="popAlarmDateS" type="text" value="" style="width:100%; border:0px;" readonly/>	
			         		</td>
							<th >최종알림시간</th>
			         		<td class="tleft">
			         			<input class="readonlyWhite" id="popAlarmDateE" name="popAlarmDateE" type="text" value="" style="width:100%; border:0px;" readonly/>
			         		</td>
						</tr>
						<tr>
			         		<th>장애내용</th>
			         		<td id="popAlarmMessage" colspan="3" class="tleft">			         			 
			         		</td>
						</tr>
					</tbody>
				</table>
				<!-- //테이블 2단 -->
				
				<!-- 테이블 3단 -->
				<table class="mt_5">
			    	<col width="17%" />
			    	<col />
			    	<tbody>
			       		<tr>
			         		<th>A/S 기사</th>
			         		<td colspan="3" class="tleft">
								<input class="readonlyWhite" id="popAsEngineer" name="popAsEngineer" type="text" style="width:100%;" value="" />
							</td>
						</tr>
						<tr>
			         		<th>조치방법</th>
			         		<td class="tleft">
			         			<span class="r_radio">			         			
			         				<c:forEach var="vo" items="${selectVoAsTypeList}" varStatus="status" >
										<input id="popAsMethod_${vo.value}"  name="popAsMethod" type="radio" value='${vo.value}' required	 />	<label for="popAsMethod_${vo.value}">${vo.name}</label>										
									</c:forEach>
								</span>	
							</td>
						</tr>
						<tr>
							<th>조치내용</th>
			         		<td class="tleft">
								<textarea id="popAsNote" name="popAsNote" rows="5" cols="40" style="width:100%;"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- //테이블 3단 -->				
			</form>
		</div>	
		<!-- //테이블 영역 -->
		
		<!-- 버튼 그룹 -->
		<div class="r_pageBtnWrapper">
			<span class="pageNormal">
				<button onclick="javascript:fncCancel()">닫기</button>
			</span>			
			<span id="btnDiv" class="pageNormal save">
				<button onclick="javascript:fncSave();">저장</button>
			</span>			
		</div>
		<!-- //버튼 그룹 -->
		
	</div>
</div>
