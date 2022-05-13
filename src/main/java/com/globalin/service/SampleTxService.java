package com.globalin.service;

public interface SampleTxService {

	// 실제로 데이터를 추가해 주는 메소드
	// 데이터를 추가하려면 mapper를 통해서 
	// sample1mapper , sample2mapper 가 필요하다.
	public void addData(String value);
	
	
}
