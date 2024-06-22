

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<script language="JavaScript">

	alert('11');	
	//console.log( '${storeList}' );
	
	
	$.ajax({
		url:'/bleStoreList',
		type:'POST',
		cache:false,		
		dataType:'json',
		success:function(data){
			alert('yes');
		},
		error:function(result){
			alert('no');
		}
	});


</script>

</head>

<body >

	<p>blank.html - Needed for Internet Explorer's hidden iframe</p>
	<p id="output"></p>

</body>
</html>


