DROP TABLE IF EXISTS [account];
CREATE TABLE [account] (
  [id] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  [username] varchar(64) DEFAULT NULL
);

DROP TABLE IF EXISTS [box_type];
CREATE TABLE [box_type] (
  [id] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  [name] varchar(32) NOT NULL,
  FOREIGN KEY ([account_id]) REFERENCES [account] ([id]) 
   ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO [box_type] VALUES ('1','Small');
INSERT INTO [box_type] VALUES ('2','Medium');
INSERT INTO [box_type] VALUES ('3','Large');

DROP TABLE IF EXISTS [box_status];
CREATE TABLE [box_status] (
  [id] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  [name] varchar(32) NOT NULL,
  FOREIGN KEY ([account_id]) REFERENCES [account] ([id]) 
   ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO [box_status] VALUES ('1','In Storage');
INSERT INTO [box_status] VALUES ('2','Inbound');
INSERT INTO [box_status] VALUES ('3','Outbound');


DROP TABLE IF EXISTS [warehouse];
CREATE TABLE [warehouse] (
  [id] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  [name] varchar(32) NOT NULL,
  [address] varchar(255) NOT NULL
);

DROP TABLE IF EXISTS [box];
CREATE TABLE [box] (
  [id] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  [account_id] INTEGER NOT NULL,
  [type_id] INTEGER NOT NULL,
  [status_id] INTEGER NOT NULL,
  [warehouse_id] INTEGER,
  [name] varchar(32) NOT NULL,
  FOREIGN KEY ([account_id]) REFERENCES [account] ([id]) 
   ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY ([type_id]) REFERENCES [box_type] ([id]) 
   ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY ([status_id]) REFERENCES [box_status] ([id]) 
   ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY ([warehouse_id]) REFERENCES [warehouse] ([id]) 
   ON DELETE CASCADE ON UPDATE CASCADE
);


