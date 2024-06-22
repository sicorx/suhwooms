** 이클립스 설정 관련 좋은 정보 있으시면
** 여기에 기록하여 함께 공유하여 주십시요.


★★ Windown > Preferences

1. FONT 설정
- General > Appearance > Colors and Fonts 
						- Basic > Text Font (Edit...) : 나눔 고딕 코딩/보통/10/한글 
						 (font 설치 파일 : Z:\3. 개발\참고자료\NanumGothicCoding_Setup-2.0.exe) 


2. ENCODING 설정
- General > Content Types
						- Java Class File - Default encoding : UTF-8 (update)
- General > Content Types
						- Text - Default encoding : UTF-8 (update)
- General > Content Types
						- Text > Java Properties File - Default encoding : UTF-8 (update)
- General > Content Types
						- Text > JSP - Default encoding : UTF-8 (update)
- Web > CSS Files
						- Encoding : ISO 10646/Unicode(UTF-8)
- Web > HTML Files
						- Encoding : ISO 10646/Unicode(UTF-8)
- Web > JSP Files
						- Encoding : ISO 10646/Unicode(UTF-8)
- XML > XML Files
						- Encoding : ISO 10646/Unicode(UTF-8)


3. 주석 설정
- 선행 : eclipse.ini 파일을 오픈 한 후 마지막 라인에 -Duser.name=본인이름 을 추가 후 이클립스 재실행

- Java > Code Style > Code Templates 
						- Comments > Types (Edit...) : 
/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : ${package_name}
 * @Class Name : ${file_name}
 * @Description : 
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ ${date}     ${user}      최초생성
 * 
 * @author ${user}
 * @since ${date} ${time}
 * @version 2.0
 * 
 */

- Java > Code Style > Code Templates 
						- Comments > Methods (Edit...) : 
/**
 * 메서드의 기능설명은 한 두줄로 간결하게..
 * 
 * @author ${user}
 * @param 
 * @return 
 * @exception Exception
 */

- JavaScript > Code Style > Code Templates 
						- Comments > Functions (Edit...) : 
/**
 *  함수명 : 설명
 *  
 * @author ${user}
 * @param 
 * @return 
 */
 
 (주석 달때 단축키 : ALT + SHIFT + j)
 
 
 4. SVN 예외 처리
- Team
						- Ignored Resources (Add Pattern...)
						target 추가
						.project 추가
						.settings 추가
						.classpath 추가
 
 
 
  ★★ plug in 설치
 
 1. properties Editor
 - Help > Install New Software...
 						- (Add...)
 						  Name: properties Editor
 						  Location : http://propedit.sourceforge.jp/eclipse/updates/
 						- 목록에서 PropertiseEditor > Propertise Editor
 						           PropertiseEditor > PropertiseEditor_Asian_NLS
 						  위 두개 체크 후 설치



  ★★ pom.xml 추가
  
1. log4jdbc remix 
		<!-- log4jdbc remix -->	
		<dependency>
			<groupId>org.lazyluke</groupId>
			<artifactId>log4jdbc-remix</artifactId>
			<version>0.2.7</version>
		</dependency>

2. json lib
		<!-- JSON -->
  		<dependency>
   			<groupId>net.sf.json-lib</groupId>
   			<artifactId>json-lib</artifactId>
   			<version>2.4</version>
   			<classifier>jdk15</classifier>
  		</dependency>