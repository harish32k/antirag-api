use Hackathonproject;
create table Admin(
	Aid varchar(100), fname varchar(100), pword varchar(100), email varchar(100) unique, phone varchar(20) unique, PRIMARY KEY (Aid) 
);

insert into Admin values('1', 'admin1', 'password1', 'admin1@mail.com', '1234567890');
insert into Admin values('2', 'admin2', 'password2', 'admin2@mail.com', '2345678901');

create table Student(
	sname varchar(100), Aid varchar(100),  pword varchar(100),
    branch varchar(20), phone varchar(20) unique, roll varchar(10),
    email varchar(100) unique, pphone varchar(20), address varchar(200),
    primary key (roll), FOREIGN KEY (Aid) REFERENCES Admin(Aid)
);

insert into Student values('student1', '1', 'spassword1', 'CSE', '3456789012', '111', 'st1@mail.com', '4567890123', 'aaa bbb ccc');

create table Complaints(
	roll varchar(10), Aid varchar(100), culprit varchar(100), time_c varchar(100), place varchar(100),
    details varchar(500), level_of_threat int, cid int AUTO_INCREMENT, image mediumblob, resolved int,
    primary key (cid), foreign key (Aid) references Admin (Aid), foreign key (roll) references Student(roll)
);

create table Message(
	roll varchar(10), message varchar(500), cid int, 
    foreign key (cid) references Complaints (cid), foreign key (roll) references Student (roll) 
);

create table Unopened(
	roll varchar(10),
    foreign key (roll) references Student (roll)
);


drop table Admin;
drop table Student;
drop table Complaints;
drop table Unopened;
select * from Admin;
select * from Student;