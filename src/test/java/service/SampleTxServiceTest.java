package service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.globalin.service.SampleTxService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class SampleTxServiceTest {

	@Autowired
	private SampleTxService service;
	
	
	@Test
	public void testAddData() {
		
		String data = "가가가가가가가가가\r\n"
				+ "나나나나나나나나나나나\r\n"
				+ "다다다다다다다다다다다\r\n"
				+ "라라라라라라라라라라라\r\n"
				+ "마마마마마마마마마마마";
		
		System.out.println(data.getBytes().length);
		service.addData(data);
		
	}
	
	
	
}
