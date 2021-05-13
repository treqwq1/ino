package ino.web.freeBoard.service;

import ino.web.freeBoard.dto.FreeBoardDto;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FreeBoardService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;


	public List<FreeBoardDto> freeBoardList(HashMap<String, Object> map){
		System.out.println("서비스호출");
		return sqlSessionTemplate.selectList("freeBoardGetList",map);
	}


	public int freeBoardInsertPro(FreeBoardDto dto){
		int num=sqlSessionTemplate.insert("freeBoardInsertPro",dto);
		//System.out.println(dto.getNum());
		return num;
	}

	public FreeBoardDto getDetailByNum(int num){
		return sqlSessionTemplate.selectOne("freeBoardDetailByNum", num);
	}

	public int getNewNum(){
		return sqlSessionTemplate.selectOne("freeBoardNewNum");
	}

	public int freeBoardModify(FreeBoardDto dto){
		int num=sqlSessionTemplate.update("freeBoardModify", dto);
		return num;
	}

	public int freeBoardDelete (int num) {
		int a=sqlSessionTemplate.delete("freeBoardDelete", num);
		return a;
	}


	public FreeBoardDto freeBoardfindDto(int num) {
		return sqlSessionTemplate.selectOne("freeBoardfindDto",num);
		// TODO Auto-generated method stub
		
	}


	public int freeBoardDelete(ArrayList<Integer> check) {
		System.out.println("서비스호출");
		int num=sqlSessionTemplate.delete("freeBoardDeleteCK",check);
		
		System.out.println(num);
		// TODO Auto-generated method stub
		return num;
	}


	public int freeBoardcnt(HashMap<String, Object> map) {
		int listcnt=sqlSessionTemplate.selectOne("freeBoardcnt", map);
		return listcnt;
	}


	public List<Map<String, Object>> freeBoardcommon() {
		return sqlSessionTemplate.selectList("freeBoardCommon");
	}

	





}
