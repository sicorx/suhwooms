package rems.system.persistence;

import java.util.HashMap;
import java.util.List;

import rems.system.model.NoticeVo;

public interface NoticeMapper {
	
	public List<NoticeVo> retrieveNotice(HashMap<String, Object> params);
	
	public NoticeVo retrieveNoticeDtl(HashMap<String, Object> params);
	
	public List<NoticeVo> retrieveNoticeTargetDtl(HashMap<String, Object> params);
	
	void saveNotice(NoticeVo params);

	String selectNoticeId(NoticeVo params);

	void saveNoticeTarget(NoticeVo params);

	void saveNoticeTargetOrgCd(NoticeVo params);

	void deleteNoticeTarget(NoticeVo params);

	void deleteNoticeTargetOrg(NoticeVo params);

	public List<NoticeVo> retrieveNoticeTargetOrgDtl(HashMap<String, Object> params);

	public void saveNoticeUpdate(NoticeVo noticeVo);

	public int retrieveNoticeViewCnt(NoticeVo noticeVo);

	

	

	

}
