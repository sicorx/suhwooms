package rems.system.service;

import java.util.HashMap;
import java.util.List;

import rems.system.model.NoticeVo;

public interface NoticeSvc {
	
	public void saveNotice(NoticeVo params);

	public String selectNoticeId(NoticeVo noticeVo);

	public void saveNoticeTarget(NoticeVo noticeVo);

	public void saveNoticeTargetOrgCd(NoticeVo noticeVo);

	public void deleteNoticeTarget(NoticeVo noticeVo);

	public void deleteNoticeTargetOrg(NoticeVo noticeVo);

	public List<NoticeVo> retrieveNotice(HashMap<String, Object> params);

	public NoticeVo retrieveNoticeDtl(HashMap<String, Object> params);

	public List<NoticeVo> retrieveNoticeTargetDtl(HashMap<String, Object> params);

	public List<NoticeVo> retrieveNoticeTargetOrgDtl(HashMap<String, Object> params);

	public void saveNoticeUpdate(NoticeVo noticeVo);

	public int retrieveNoticeViewCnt(NoticeVo noticeVo);
}
