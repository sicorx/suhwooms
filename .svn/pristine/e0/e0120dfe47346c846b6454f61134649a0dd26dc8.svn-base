package rems.system.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import rems.common.persistence.CommonMapper;
import rems.system.model.NoticeVo;
import rems.system.persistence.NoticeMapper;

@Service
public class NoticeSvcImpl implements NoticeSvc {
	
	@Autowired
	private NoticeMapper noticeMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	@Transactional
	@Override
	public List<NoticeVo> retrieveNotice(HashMap<String, Object> params) {
		
		List<NoticeVo> list = noticeMapper.retrieveNotice(params);
		
		int cnt = commonMapper.selectTotalCnt();
		
		if( cnt != 0 ){
			list.get(0).setTotal(String.valueOf(cnt));	
		}
		
		return list;
	}	
	
	@Override
	public NoticeVo retrieveNoticeDtl(HashMap<String, Object> params){
		return noticeMapper.retrieveNoticeDtl(params);
	}
	
	@Override
	public List<NoticeVo> retrieveNoticeTargetDtl(HashMap<String, Object> params){
		return noticeMapper.retrieveNoticeTargetDtl(params);
	}
	
	@Override
	public List<NoticeVo> retrieveNoticeTargetOrgDtl(HashMap<String, Object> params){
		return noticeMapper.retrieveNoticeTargetOrgDtl(params);
	}
	
	@Override
	public void saveNotice(NoticeVo params){	
		noticeMapper.saveNotice(params);
	}
	
	@Override
	public void saveNoticeUpdate(NoticeVo noticeVo){
		noticeMapper.saveNoticeUpdate(noticeVo);
	}
	
	@Override
	public String selectNoticeId(NoticeVo params){	
		String noticeId = noticeMapper.selectNoticeId(params);
		return noticeId;
	}
	
	@Override
	public void saveNoticeTarget(NoticeVo params){	
		noticeMapper.saveNoticeTarget(params);
	}
	
	@Override
	public void saveNoticeTargetOrgCd(NoticeVo params){	
		noticeMapper.saveNoticeTargetOrgCd(params);
	}
	
	@Override
	public void deleteNoticeTarget(NoticeVo params){	
		noticeMapper.deleteNoticeTarget(params);
	}
	
	@Override
	public void deleteNoticeTargetOrg(NoticeVo params){	
		noticeMapper.deleteNoticeTargetOrg(params);
	}
	
	public int retrieveNoticeViewCnt(NoticeVo noticeVo){
		return noticeMapper.retrieveNoticeViewCnt(noticeVo);
	}
}
