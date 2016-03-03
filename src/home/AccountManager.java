package home;

import java.util.*;

public class AccountManager {
	
	private ArrayList<User> accounts;
	
	public AccountManager() {
		accounts = new ArrayList<User>();
	}
	
	public boolean accountExists(String name) {
		for(int i = 0; i < accounts.size(); i++) {
			if (accounts.get(i).name.equals(name)) {
				return true;
			}
		}
		return false;
	}
	
	public boolean passwordMatchesAccount(String name, String password) {
		for(int i = 0; i < accounts.size(); i++) {
			if (accounts.get(i).name.equals(name)) {
				return accounts.get(i).password.equals(password); 
			}
		}
		return false;
	}
	
	public boolean createNewAccount(String name, String password) {
		for(int i = 0; i < accounts.size(); i++) {
			if(accounts.get(i).name.equals(name)) {
				return false;
			}
		}
		User newAccount = new User(name, password);
		accounts.add(newAccount);
		return true;
	}
}
