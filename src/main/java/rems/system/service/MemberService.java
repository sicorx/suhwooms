package rems.system.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import rems.system.persistence.SystemMapper;
import rems.util.Constants;

public class MemberService implements UserDetailsService {

	@Autowired
	private SystemMapper systemMapper;
		
	private static final Logger LOGGER = LoggerFactory.getLogger( MemberService.class );
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
				
		LOGGER.info( "loadUserByUsername : " + username);

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", username);
		params.put("encKey", Constants.ENCRYPT_KEY);
		
		String userPw = systemMapper.retrieveUserPw(params);
		
		Collection<SimpleGrantedAuthority> roles = new ArrayList<SimpleGrantedAuthority>();
		roles.add(new SimpleGrantedAuthority("ROLE_USER"));
		
		UserDetails user = new User(username, userPw, roles);
		
		return user;
	}
}
