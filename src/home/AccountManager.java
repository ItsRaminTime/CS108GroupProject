package home;

import java.util.*;

public class AccountManager {
	
	/*
	 * accounts is the list of all the users in the system.
	 * It gets loaded into the servlet context when the website is launched.
	 */
	//public ArrayList<User> accounts;
	public HashMap<String,User> accounts;
	
	public AccountManager() {
		accounts = new HashMap<String, User>();
		createNewAccount("Patrick", "1234");
		createNewAccount("Molly", "FloPup");
	}
	
	public boolean accountExists(String name) {
		return accounts.containsKey(name);
	}
	
	public boolean passwordMatchesAccount(String name, String password) {
		return accounts.get(name).password.equals(password);
		
	}
	
	public boolean createNewAccount(String name, String password) {
		if (accounts.containsKey(name)) return false;
		User newAccount = new User(name, password);
		accounts.put(name, newAccount);
		return true;
	}
}
