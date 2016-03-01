package home;

import java.util.*;

public class AccountManager {
	
	private ArrayList<Account> accounts;
	
	public class Account {
		
		private String name;
		private String password;
		
		public Account(String enteredName, String enteredPassword) {
			this.name = enteredName;
			this.password = enteredPassword;
		}
		
		public String getPassword() {
			return this.password;
		}
		
		public String getName() {
			return this.name;
		}
	}
	
	public AccountManager() {
		accounts = new ArrayList<Account>();
		createNewAccount("Patrick", "1234");
		createNewAccount("Molly", "FloPup");
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
		Account newAccount = new Account(name, password);
		accounts.add(newAccount);
		return true;
	}
}
