package com.globalin.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.globalin.mapper.Sample1Mapper;
import com.globalin.mapper.Sample2Mapper;

@Service
public class sampleTxServiceImpl implements SampleTxService {
	
	
	//로그
	private Logger log = LoggerFactory.getLogger(sampleTxServiceImpl.class);

	@Autowired
	private Sample1Mapper mapper1;
	@Autowired
	private Sample2Mapper mapper2;
	
	// 둘중 하나라도 실패하면 롤백해버린다.
	@Transactional
	@Override
	public void addData(String value) {
		
		log.info("mapper1.....");
		mapper1.insertCol1(value);
		
		log.info("mapper2.....");
		mapper2.insertCol2(value);
		
		log.info("end.........");
		
	}

}
