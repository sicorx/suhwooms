package rems.eqmt.persistence;

import java.util.HashMap;
import java.util.List;

import rems.eqmt.model.SystemVo;

public interface EqmtElectricMgntMapper {

	List<SystemVo> retrieveElecMgntList(HashMap<String, Object> params);

	public int saveElectricMgnt(SystemVo gvmVo);

	boolean checkElectricTF(SystemVo gvmVo);

	boolean deleteElectricMgnt(SystemVo gvmVo);

	int checkElecCd(HashMap<String, Object> params);

}
