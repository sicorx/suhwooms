package rems.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketAddress;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import rems.eqmt.model.ControlInverterVo;
import rems.util.model.EMSModel;
public class EMSController {
	
    public static String SOCKET_IP = "27.122.202.85";
	//public static Integer SOCKET_PORT = 10020;
    public static Integer SOCKET_PORT = 10020;
	
	
	//public static String DP_SOCKET_IP = "175.209.61.131";
	//public static Integer DP_SOCKET_PORT = 10020;	
	
	public static String DP_SOCKET_IP = "27.122.202.85";
	public static Integer DP_SOCKET_PORT = 10030;
	
	private final String timediff;
	
	public EMSController(String timediff) {
		this.timediff = timediff;
	}
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EMSController.class);
	
	public boolean applyDimmingValue(int gwId, int value) {
		
		int comnd = 0x0001;
		int length = 14;
		
		byte[] data = new byte[14];
		
		// header : [0],[1],[2],[3]
		data[0] = 0x16;
		data[1] = 0x16;
		data[2] = 0x16;
		data[3] = 0x16;

		// length : [4],[5]
		this.setLength(data, length);

		// target : [6],[7]
		this.setAscii(data, 6, 'M');
		this.setAscii(data, 7, 'G');

		// target : [8],[9]
		this.setGatewayId(data, gwId);

		// target : [10],[11]
		this.setCommand(data, comnd);

		// value : [12]
		data[12] = (byte)value;
		
		// ETX : [13]
		data[13] = 0x03;

		Socket soc = null;
		InputStream is = null;
		OutputStream out = null;
		
		byte[] buf = new byte[16];

		try {
				
			soc = new Socket(SOCKET_IP,SOCKET_PORT);
			
            out = (OutputStream) soc.getOutputStream();
            out.write(data);

            is = soc.getInputStream();
			is.read(buf);

			LOGGER.info("Connection connected after process? " + soc.isConnected() );
			LOGGER.info("Connection closed after process? " + soc.isClosed() );
			LOGGER.info("Connection bound after process? " + soc.isBound() );
			
			soc.close();
			is.close();
			
		} catch (IOException e) {
			LOGGER.info(e.getMessage());
		}
		
		return getErrMsg(buf);
	}

	public boolean applyDimmingLevel(int gwId, int value) {
		
		assert value == -10 || value == 0 || value == 10;
		
		int comnd = 0x0002;
		int length = 14;
		
		byte[] data = new byte[14];
		
		// header : [0],[1],[2],[3]
		data[0] = 0x16;
		data[1] = 0x16;
		data[2] = 0x16;
		data[3] = 0x16;

		// length : [4],[5]
		this.setLength(data, length);

		// target : [6],[7]
		this.setAscii(data, 6, 'M');
		this.setAscii(data, 7, 'G');

		// target : [8],[9]
		this.setGatewayId(data, gwId);

		// target : [10],[11]
		this.setCommand(data, comnd);

		// value : [12]
		data[12] = (byte)value;
		
		// ETX : [13]
		data[13] = 0x03;
		
		Socket soc = null;
		InputStream is = null;
		OutputStream out = null;
		
		byte[] buf = new byte[14];

		try {
				
			soc = new Socket(SOCKET_IP,SOCKET_PORT);
			
            out = (OutputStream) soc.getOutputStream();
            out.write(data);

            is = soc.getInputStream();
			is.read(buf);

			LOGGER.info("Connection connected after process? " + soc.isConnected() );
			LOGGER.info("Connection closed after process? " + soc.isClosed() );
			LOGGER.info("Connection bound after process? " + soc.isBound() );
			
			soc.close();
			is.close();
			
		} catch (IOException e) {
			LOGGER.info(e.getMessage());
		}
		
		return getErrMsg(buf);
	}

	public boolean applyHAConLevel(int gwId, int value) {
		
		assert value == -1 || value == 0 || value == 1;
		
		int comnd = 0x0003;
		int length = 14;
		
		byte[] data = new byte[14];
		
		// header : [0],[1],[2],[3]
		data[0] = 0x16;
		data[1] = 0x16;
		data[2] = 0x16;
		data[3] = 0x16;

		// length : [4],[5]
		this.setLength(data, length);

		// target : [6],[7]
		this.setAscii(data, 6, 'M');
		this.setAscii(data, 7, 'G');

		// target : [8],[9]
		this.setGatewayId(data, gwId);

		// target : [10],[11]
		this.setCommand(data, comnd);

		// value : [12]
		data[12] = (byte)value;
		
		// ETX : [13]
		data[13] = 0x03;
	
		Socket soc = null;
		InputStream is = null;
		OutputStream out = null;
		
		byte[] buf = new byte[14];

		try {
				
			soc = new Socket(SOCKET_IP,SOCKET_PORT);
			
            out = (OutputStream) soc.getOutputStream();
            out.write(data);

            is = soc.getInputStream();
			is.read(buf);

			LOGGER.info("Connection connected after process? " + soc.isConnected() );
			LOGGER.info("Connection closed after process? " + soc.isClosed() );
			LOGGER.info("Connection bound after process? " + soc.isBound() );
			
			soc.close();
			is.close();
			
		} catch (IOException e) {
			LOGGER.info(e.getMessage());
		}
		
		return getErrMsg(buf);
	}
	
	public boolean applyHAConSchedule(int gwId, String onoffHours) {
		
		assert onoffHours != null && onoffHours.length() == 24;
		
		int comnd = 0x0004;
		int length = 16;
		
		byte[] data = new byte[16];
		
		// header : [0],[1],[2],[3]
		data[0] = 0x16;
		data[1] = 0x16;
		data[2] = 0x16;
		data[3] = 0x16;

		// length : [4],[5]
		this.setLength(data, length);

		// target : [6],[7]
		this.setAscii(data, 6, 'M');
		this.setAscii(data, 7, 'G');

		// target : [8],[9]
		this.setGatewayId(data, gwId);

		// target : [10],[11]
		this.setCommand(data, comnd);

		// value : [12],[13],[14]
		this.setOnoffTime(data, onoffHours);
		
		// ETX : [15]
		data[15] = 0x03;
		
		Socket soc = null;
		InputStream is = null;
		OutputStream out = null;
		
		byte[] buf = new byte[16];

		try {
				
			soc = new Socket(SOCKET_IP,SOCKET_PORT);
			
            out = (OutputStream) soc.getOutputStream();
            out.write(data);

            is = soc.getInputStream();
			is.read(buf);

			LOGGER.info("Connection connected after process? " + soc.isConnected() );
			LOGGER.info("Connection closed after process? " + soc.isClosed() );
			LOGGER.info("Connection bound after process? " + soc.isBound() );
			
			soc.close();
			is.close();
			
		} catch (IOException e) {
			LOGGER.info(e.getMessage());
		}
		
		return getErrMsg(buf);
	}

	public boolean applySignOnOff(int gwId, int value) {
		
		assert value == 0 || value == 1;
		
		int comnd = 0x0006;
		int length = 14;
		
		byte[] data = new byte[14];
		
		// header : [0],[1],[2],[3]
		data[0] = 0x16;
		data[1] = 0x16;
		data[2] = 0x16;
		data[3] = 0x16;

		// length : [4],[5]
		this.setLength(data, length);

		// target : [6],[7]
		this.setAscii(data, 6, 'M');
		this.setAscii(data, 7, 'G');

		// target : [8],[9]
		this.setGatewayId(data, gwId);

		// target : [10],[11]
		this.setCommand(data, comnd);

		// value : [12]
		data[12] = (byte)value;
		
		// ETX : [13]
		data[13] = 0x03;
		
		Socket soc = null;
		InputStream is = null;
		OutputStream out = null;
		
		byte[] buf = new byte[15];

		try {
				
			soc = new Socket(SOCKET_IP,SOCKET_PORT);
			
            out = (OutputStream) soc.getOutputStream();
            out.write(data);

            is = soc.getInputStream();
			is.read(buf);

			LOGGER.info("Connection connected after process? " + soc.isConnected() );
			LOGGER.info("Connection closed after process? " + soc.isClosed() );
			LOGGER.info("Connection bound after process? " + soc.isBound() );
			
			soc.close();
			is.close();
			
		} catch (IOException e) {
			LOGGER.info(e.getMessage());
		}
		
		return getErrMsg(buf);
	}
	
	public boolean applyHaconControl(int gwId, String jobMode, String operMode,int onOffVal, int confVal ) {
		
		int comnd = 0xC005;
		int length = 15;
		
		byte[] data = new byte[15];
		
		// header : [0],[1],[2],[3]
		data[0] = 0x16;
		data[1] = 0x16;
		data[2] = 0x16;
		data[3] = 0x16;

		// length : [4],[5]
		this.setLength(data, length);

		// target : [6],[7]
		this.setAscii(data, 6, 'M');
		this.setAscii(data, 7, 'G');

		// target : [8],[9]
		this.setGatewayId(data, gwId);

		// target : [10],[11]
		this.setCommand(data, comnd);

		// value : [12],[13]
		if( jobMode.equalsIgnoreCase("p") ){
            
			String jobSp = operMode+onOffVal;
			
			switch (jobSp){

				case "c1" : //냉방 on 시
					data[12] = 0x00;
					data[13] = (byte) 0xFF;
					break;
				case "c0" : //냉방 off 시
					data[12] = 0x00;
					data[13] = 0x00;
					break;
				case "h1" : //난방 on 시
					data[12] = 0x01;
					data[13] = (byte) 0xFF;
					break;
				case "h0" : //난방 off 시
					data[12] = 0x01;
					data[13] = 0x00;
					break;
				default : LOGGER.info("error");

			}
	
		}else if( jobMode.equalsIgnoreCase("t") ){
			
			switch ( operMode ){
			
				case "c" :
					data[12] = 0x00;
					data[13] = (byte)confVal;
					break;
				case "h" :
					data[12] = 0x01;
					data[13] = (byte)confVal;
					break;
				default : LOGGER.info("error");
			
			}
		}
		
		// ETX : [14]
		data[14] = 0x03;
		
		Socket soc = null;
		InputStream is = null;
		OutputStream out = null;
		
		byte[] buf = new byte[15];

		try {
				
			soc = new Socket(SOCKET_IP,SOCKET_PORT);
			
            out = (OutputStream) soc.getOutputStream();
            out.write(data);

            is = soc.getInputStream();
			is.read(buf);
			
			LOGGER.info("Connection connected after process? " + soc.isConnected() );
			LOGGER.info("Connection closed after process? " + soc.isClosed() );
			LOGGER.info("Connection bound after process? " + soc.isBound() );
			
			soc.close();
			is.close();
			
		} catch (IOException e) {
			LOGGER.info(e.getMessage());
		}
		return getErrMsg(buf);
	}
	
	public boolean controlSigleInveterMachine(ControlInverterVo controlInverterVo) {
		
		int GWID = controlInverterVo.getGwId();
		int comnd =  0xA001;
		int parantBasicLength = 13;
		int singleChildBasicLength = 24;
		int controlMachineCnt = 1;
		int length = parantBasicLength + singleChildBasicLength;
		
		float settingTemp = controlInverterVo.getSensTempConf();
		int settingTempValue = (int)(settingTemp * 10);
		
		byte[] data = new byte[length];

		data[0] = 0x16;
		data[1] = 0x16;
		data[2] = 0x16;
		data[3] = 0x16;
		data[4] = (byte)((length & 0x0000FF00) >> 8);
		data[5] = (byte)((length & 0x000000FF));
		data[6] = (byte)('M' & 0x000000FF);
		data[7] = (byte)('S' & 0x000000FF);
		data[8] = (byte)((GWID & 0x0000FF00) >> 8);
		data[9] = (byte)((GWID & 0x000000FF));
		data[10] = (byte)((comnd & 0x0000FF00) >> 8);
		data[11] = (byte)((comnd & 0x000000FF));

		/************
		    inverter 시작
		************/
		
		data[12] = 0x02; //1
		data[13] = (byte)singleChildBasicLength;
		data[14] = (byte)0xFF;
		data[15] = 0x01;
		data[16] = (byte)controlMachineCnt;
		
		data[17] = 0x01;//address
		
		data[18] = (byte)controlInverterVo.getControlFlag1();
		data[19] = (byte)controlInverterVo.getControlFlag2();
		data[20] = (byte)controlInverterVo.getAlarmMask1();
		data[21] = (byte)controlInverterVo.getAlarmMask2();
		
		if(controlInverterVo.getOperMode() == 17 ){
			data[22] = 0x11;	
		}else{
			data[22] = 0x12;	
		}
		
		data[23] = (byte)( settingTempValue & 0x00FF);
		data[24] = (byte)((settingTempValue & 0xFF00) >> 8);
		
		data[25] = (byte)controlInverterVo.getMaxTempAlarmYn();
		data[26] = (byte)controlInverterVo.getMaxTemp();
		data[27] = (byte)controlInverterVo.getMinTempAlarmYn();
		data[28] = (byte)controlInverterVo.getMinTemp();
		
		data[29] = (byte)controlInverterVo.getDefrostTempConf();
		data[30] = (byte)controlInverterVo.getDefrostTerm();
		data[31] = (byte)controlInverterVo.getDefrostDelay();
		data[32] = (byte)controlInverterVo.getDewaterDelay();
		
		//crc
		data[33] = 0x00;
		data[34] = 0x00;
		
		data[35] = 0x03;//24
		
		/************
	        inverter 종료
		************/
		
		data[36] = 0x03;
		
		Socket soc = null;
		InputStream is = null;
		OutputStream out = null;
		
		byte[] buf = new byte[15];

		try {
				
			soc = new Socket(SOCKET_IP,SOCKET_PORT);
			
            out = (OutputStream) soc.getOutputStream();
            out.write(data);

            is = soc.getInputStream();
			is.read(buf);

			LOGGER.info("Connection connected after process? " + soc.isConnected() );
			LOGGER.info("Connection closed after process? " + soc.isClosed() );
			LOGGER.info("Connection bound after process? " + soc.isBound() );
			
			soc.close();
			is.close();
			
		} catch (IOException e) {
			LOGGER.info(e.getMessage());
		}
		
		return getErrMsg(buf);
	}
	
	public EMSModel getState2(int gwId) {
		
		int comnd = 0x0009;
		int length = 13;
		
		byte[] data = new byte[13];
		
		// header : [0],[1],[2],[3]
		data[0] = 0x16;
		data[1] = 0x16;
		data[2] = 0x16;
		data[3] = 0x16;

		// length : [4],[5]
		this.setLength(data, length);

		// target : [6],[7]
		this.setAscii(data, 6, 'M');
		this.setAscii(data, 7, 'G');

		// target : [8],[9]
		this.setGatewayId(data, gwId);

		// target : [10],[11]
		this.setCommand(data, comnd);

		// ETX : [12]
		data[12] = 0x03;
        
		SocketAddress socketAddress = new InetSocketAddress(SOCKET_IP, SOCKET_PORT);
		Socket soc = new Socket();
		InputStream is = null;
		OutputStream out = null;
		
		byte[] buf = new byte[27];

		EMSModel model = new EMSModel();
		try {

			//soc.setSoTimeout(5000);
			soc.connect(socketAddress, 3000);
			
            out = (OutputStream) soc.getOutputStream();
            out.write(data);

            is = soc.getInputStream();
			is.read(buf);

			LOGGER.info("Connection connected after process? " + soc.isConnected() );
			LOGGER.info("Connection closed after process? " + soc.isClosed() );
			LOGGER.info("Connection bound after process? " + soc.isBound() );
			
		} catch (IOException e) {
			LOGGER.info(e.getMessage());
		}finally{
			try{
				soc.close();
				is.close();	
			}catch (Exception e) {
				LOGGER.info(e.getMessage());
			}
			model = setStateValue( buf );
		}

		return model;
	}
	
	public EMSModel setStateValue(byte[] ret) {

		EMSModel model = new EMSModel();
	
		if( ret[0] != 22 ||ret[26] != 3 ){
			
			LOGGER.info("GateWay <-> Server Protocol Failed");
			model.setHaconOnOff(false);
			model.setHaconOnOffText(  "N/A"  );		

			model.setTemperature(0);
			model.setTemperatureText ( " " );
						
			model.setDimmerDimmingValue(0);
			model.setDimmerDimmingValueText( "N/A" );
			
			model.setDimmingValue(0);
			
			model.setDimmingLevel(0);
			model.setDimmingLevelText( "N/A" );
			
			model.setHaconLevel(0);
			model.setHaconLevelText(" " );
			
			model.setHaconSchedule("000000000000000000000000"); 
			
    		model.setSignMode( "N/A" );

    		model.setSignOnOff( 0);
    		
    		model.setWeatherCd( 0);
						
			String runTime = TimezoneUtils.retrieveNowByTimediffFormat( this.timediff, "yy/MM/dd HH:mm" );
			model.setRunTime( runTime );
			
			String nowTime = TimezoneUtils.retrieveNowByTimediffFormat( this.timediff, "yy/MM/dd HH:mm" );
			model.setNowTime(nowTime);
			
			model.setRunTime(runTime);
			model.result = false;
			
		}else{

			LOGGER.info("GateWay <-> Server Protocol Successed");
			model.setHaconOnOff(ret[12] == 0x01);
			boolean haconOnoff = (boolean)model.getHaconOnOff();
			model.setHaconOnOffText( haconOnoff ? "ON" : "OFF"  );		
			
			model.setHaconMode((int)ret[13]);
			
			model.setTemperature((int)(ret[14] & 0xFF));
			model.setTemperatureText (  model.getTemperature()+"" );
			
			model.setDimmerDimmingValue((int)(ret[15] & 0xFF));
			model.setDimmerDimmingValueText(  model.getDimmerDimmingValue()+""      );
			
			model.setDimmingValue((int)ret[16]);
			
			model.setDimmingLevel((int)ret[17]);
			Integer dimmingLvl = model.getDimmingLevel();
			String dimmingLv = dimmingLvl == -10 ? "L" : (dimmingLvl == 10 ? "H" : "N");		
			model.setDimmingLevelText( dimmingLv );
			
			model.setHaconLevel((int)ret[18]);
			Integer hAConLvl = model.getHaconLevel();
			model.setHaconLevelText( hAConLvl == -1 ? "L" : (hAConLvl == 1 ? "H" : "N")  );
			
			model.setHaconSchedule(lpad(Integer.toBinaryString(ret[19] & 0xFF), 8, "0") 
					+ lpad(Integer.toBinaryString(ret[20] & 0xFF), 8, "0") 
					+ lpad(Integer.toBinaryString(ret[21] & 0xFF), 8, "0"));
			
			String signMode = "";
    		
    		signMode += (char)ret[22];
    		signMode += (char)ret[23];
    		model.setSignMode( signMode );

    		model.setSignOnOff( (int)ret[24]);
    		int setSignOnOff = model.getSignOnOff();
    		model.setSignOnOffText( setSignOnOff == 0 ? "OFF" : "ON" );
    		
    		model.setWeatherCd( (int)ret[25]);
						
			String runTime = TimezoneUtils.retrieveNowByTimediffFormat( this.timediff, "yy/MM/dd HH:mm" );
			model.setRunTime(runTime);
			
			String nowTime = TimezoneUtils.retrieveNowByTimediffFormat( this.timediff, "yy/MM/dd HH:mm" );
			model.setNowTime(nowTime);
			
			model.result = true;
		}
		return model;
	}
	
	public boolean getErrMsg(byte[] ret) {
		if(ret != null && ret.length > 9 && ret[0] == 0x16) {
			return true; //success
		}
		return false;
	}
	
	private String lpad(String str, int len, String append)
	 {
	  String rtn = str;
	  if (str.length() < len){
	   for (int i = (len - str.length()); i > 0; i--){
	    rtn = append + rtn;
	   }
	  }
	  return rtn;
	 } 

	private void setGatewayId(byte[] data, int id) {
		data[8] = (byte)((id & 0x0000FF00) >> 8);
		data[9] = (byte)((id & 0x000000FF));
	}
	
	private void setCommand(byte[] data, int cmd) {
		data[10] = (byte)((cmd & 0x0000FF00) >> 8);
		data[11] = (byte)((cmd & 0x000000FF));
	}
	
	private void setAscii(byte[] data, int pos, char value) {
		data[pos] = (byte)(value & 0x000000FF);
	}
	
	private void setLength(byte[] data,  int length) {
		data[4] = (byte)((length & 0x0000FF00) >> 8);
		data[5] = (byte)((length & 0x000000FF));
	}
	
	private void setOnoffTime(byte[] data, String value) {
		for(int i=0; i<3; i++) {
			//한바이트를 처리를 위해 8자리씩 읽는다.
			String byteVal = value.substring(i*8, (i+1)*8);
			byte[] bytes = byteVal.getBytes();
			int tmp = 0x00;
			for(int j=0; j<8; j++) {
				if(bytes[j] == '1') {
					tmp += 1;
				}
				if(j < 7) {
					tmp = (tmp << 1); //1bit 씩 이동
				}
			}
			data[12+i] = (byte)tmp;
			//System.out.println(byteVal+"="+(tmp & 0xFF)+"="+Integer.toBinaryString(tmp & 0xFF));
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	public String calculateDemandPower(int tempNum, int demandPower, float storeArea) 
	{
			
			int comnd = 0xAAAA;
			int length = 21;
			
			int recommendDemandPower = 0;
			
			byte[] data = new byte[21];
			
			// header : [0],[1],[2],[3]
			data[0] = 0x16;
			data[1] = 0x16;
			data[2] = 0x16;
			data[3] = 0x16;
	
			// length : [4],[5]
			this.setLength(data, length);
	
			// target : [6],[7]
			this.setAscii(data, 6, 'M');
			this.setAscii(data, 7, 'G');
	
			// target : [8],[9]
			//this.setGatewayId(data, gwId);
			data[8] = 0x00;
			data[9] = 0x00;
	
			// target : [10],[11]
			this.setCommand(data, comnd);
	
			// value : [12]
			data[12] = (byte)(( demandPower & 0xFF000000) >> 64);
			data[13] = (byte)(( demandPower & 0x00FF0000) >> 16);
			data[14] = (byte)(( demandPower & 0x0000FF00) >> 8);
			data[15] = (byte)(( demandPower & 0x000000FF) );
			
			data[16] = (byte)(( (int)(storeArea*10) & 0xFF000000) >> 64);
			data[17] = (byte)(( (int)(storeArea*10) & 0x00FF0000) >> 16);
			data[18] = (byte)(( (int)(storeArea*10) & 0x0000FF00) >> 8);
			data[19] = (byte)(( (int)(storeArea*10) & 0x000000FF) );
			
			
			// ETX : [13]
			data[20] = 0x03;
			
			Socket soc = null;
			InputStream is = null;
			OutputStream out = null;
			
			byte[] buf = new byte[17];
	
			try {
					
				soc = new Socket(DP_SOCKET_IP,DP_SOCKET_PORT);
				
	            out = (OutputStream) soc.getOutputStream();
	            out.write(data);
	
	            is = soc.getInputStream();
				is.read(buf);
				
				
				LOGGER.info("Data : " + buf[12] );
				LOGGER.info("Data : " + buf[13] );
				LOGGER.info("Data : " + buf[14] );
				LOGGER.info("Data : " + buf[15] );
				
				LOGGER.info("result data : " + ByteToInt((byte) (buf[12] << 24)) );
				LOGGER.info("result data : " + ByteToInt((byte) (buf[13] << 16)) );
				LOGGER.info("result data : " + ByteToInt((byte) (buf[14] << 8)) );
				LOGGER.info("result data : " + ByteToInt((byte) buf[15]) );
				
				recommendDemandPower = (int)(  ((byte)buf[12]<<24) | ((byte)buf[13]<<16) | ((byte)buf[14]<<8) | ((byte)buf[15]) );
				LOGGER.info("result sum : " +   recommendDemandPower);				
				
				
				
	
				LOGGER.info("Connection connected after process? " + soc.isConnected() );
				LOGGER.info("Connection closed after process? " + soc.isClosed() );
				LOGGER.info("Connection bound after process? " + soc.isBound() );
				
				soc.close();
				is.close();
				
			} catch (IOException e) {
				LOGGER.info(e.getMessage());
			}
			
			//return getErrMsg(buf);
			return String.valueOf( recommendDemandPower );
			
	}
	
		
	
	
	
	
	public int ByteToInt(byte myByte)
	{
		int val = myByte < 0 ? ( Byte.MAX_VALUE + 1 ) * 2 + myByte : myByte;
		return val;
	}
	
}
