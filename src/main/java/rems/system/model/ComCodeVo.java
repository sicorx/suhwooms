package rems.system.model;


public class ComCodeVo {

	private String strCd;  
	private String code;     
	private String value;    
	private String commGrpCd;
	private String commCd;   
	private String commCdNm; 

	public String getStrCd()     { return strCd;     }
	public String getCode()      { return code;      }
	public String getValue()     { return value;     }
	public String getCommGrpCd() { return commGrpCd; }
	public String getCommCd()    { return commCd;    }
	public String getCommCdNm()  { return commCdNm;  }

	public void setStrCd    (String strCd    ) { this.strCd     = strCd;     }
	public void setCode     (String code     ) { this.code      = code;      }
	public void setValue    (String value    ) { this.value     = value;     }
	public void setCommGrpCd(String commGrpCd) { this.commGrpCd = commGrpCd; }
	public void setCommCd   (String commCd   ) { this.commCd    = commCd;    }
	public void setCommCdNm (String commCdNm ) { this.commCdNm  = commCdNm;  }
}
