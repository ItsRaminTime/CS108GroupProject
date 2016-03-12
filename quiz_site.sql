USE c_cs108_masons;                                                                
                                                                                   
DROP TABLE IF EXISTS users;                                                        
DROP TABLE IF EXISTS quizzes;                                                      
DROP TABLE IF EXISTS anns;                                                         
                                                                                   
CREATE TABLE users (                                                               
      name CHAR(32),                                                                   
      data BLOB                                                                        
);                                                                                 
                                                                                   
CREATE TABLE quizzes (                                                             
      id INTEGER,                                                                      
      data BLOB                                                                        
);                                                                                 
                                                                                   
CREATE TABLE anns (                                                                
      id INTEGER,                                                                      
      data BLOB                                                                        
);  
