package ino.web.freeBoard.service;

import ino.web.freeBoard.dto.FreeBoardDto;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FreeBoardService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<FreeBoardDto> freeBoardList(Map<String, Object> data){
		return sqlSessionTemplate.selectList("freeBoardGetList", data);
	}
	public int totalCount(Map<String, Object> data){
		return sqlSessionTemplate.selectOne("totalCount", data);
	}
	

	public void freeBoardInsertPro(FreeBoardDto dto){
		sqlSessionTemplate.insert("freeBoardInsertPro",dto);
	}

	public FreeBoardDto getDetailByNum(int num){
		return sqlSessionTemplate.selectOne("freeBoardDetailByNum", num);
	}

	public int getNewNum(){
		return sqlSessionTemplate.selectOne("freeBoardNewNum");
	}

	public void freeBoardModify(FreeBoardDto dto){
		sqlSessionTemplate.update("freeBoardModify", dto);
	}

	public void FreeBoardDelete (FreeBoardDto dto) {
		sqlSessionTemplate.delete("freeBoardDelete", dto);

	}
	
	public void FreeBoardCheckDelete(List<Integer> list) {
		sqlSessionTemplate.delete("freeBoardCheckDelete", list);
	}

	
		
	
}
