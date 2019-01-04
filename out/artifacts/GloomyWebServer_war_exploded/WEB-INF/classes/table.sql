create table equipment
(
	equ_id int(10) not null auto_increment
		primary key,
	type varchar(10) null,
	location int(1) null,
	repair_price decimal(10,2) null
) default charset utf8
;
create table house
(
	house_id int(10) auto_increment
		primary key,
	community varchar(1) null,
	building_number varchar(10) null,
	unit_number varchar(10) null,
	room_number varchar(10) null,
	householder_name varchar(10) null,
	area int(10) null,
	phone_number varchar(10) null
) default charset utf8
;


create table house_record
(
	house_rec_id int(10) not null auto_increment,
	house_id int(10) null,
	area decimal(10,2) null,
	fee decimal(10,2) null,
	date timestamp default CURRENT_TIMESTAMP not null,
	is_paid int(1) null,
	primary key (house_rec_id),
	constraint house_record_ibfk_1
		foreign key (house_id) references house (house_id)
) default charset utf8
;

create index house_id
	on house_record (house_id)
;


create table parking_lot
(
	parking_id int(10) auto_increment
		primary key,
	type varchar(10) null,
	community varchar(10) null
) default charset utf8
;

create table purchase_parking_record
(
	purchase_park_rec_id int(10) not null auto_increment,
	parking_id int(10) null,
	house_id int(10) null,
	price decimal(10,2) null,
	begin_time timestamp default CURRENT_TIMESTAMP not null,
	is_paid int(1) null,
	primary key (purchase_park_rec_id),
	constraint purchase_parking_record_ibfk_1
		foreign key (parking_id) references parking_lot (parking_id),
	constraint purchase_parking_record_ibfk_2
		foreign key (house_id) references house (house_id)
) default charset utf8
;

create index house_id
	on purchase_parking_record (house_id)
;

create index parking_id
	on purchase_parking_record (parking_id)
;



create table regular_maintain_record
(
	maintain_rec_id int(10) not null auto_increment,
	equ_id int(10) not null,
	result varchar(50) null,
	repair_rec_id int(10) null,
	primary key (maintain_rec_id),
	constraint regular_maintain_record_ibfk_1
		foreign key (equ_id) references equipment (equ_id),
	constraint regular_maintain_record_ibfk_2
		foreign key (repair_rec_id) references repair_record (repair_rec_id)
) default charset utf8
;

create index equ_id
	on regular_maintain_record (equ_id)
;

create index repair_rec_id
	on regular_maintain_record (repair_rec_id)
;



create table rent_parking_record
(
	rent_park_rec_id int(10) auto_increment,
	parking_id int(10) not null,
	house_id int(10) not null,
	begin_time timestamp default CURRENT_TIMESTAMP not null,
	end_time timestamp default '0000-00-00 00:00:00' not null,
	fee int(10) null,
	is_paid int(1) null,
	primary key (rent_park_rec_id),
	constraint rent_parking_record_ibfk_2
		foreign key (parking_id) references parking_lot (parking_id),
	constraint rent_parking_record_ibfk_1
		foreign key (house_id) references house (house_id)
) default charset utf8
;

create index house_id
	on rent_parking_record (house_id)
;

create index parking_id
	on rent_parking_record (parking_id)
;

create table repair_record
(
	repair_rec_id int(10) auto_increment
		primary key,
	equ_id int(10) null,
	process varchar(50) null,
	progress int(1) null,
	staff varchar(10) null,
	date timestamp null,
	constraint repair_record_ibfk_1
		foreign key (equ_id) references equipment (equ_id)
) default charset utf8
;

create index equ_id
	on repair_record (equ_id)
;



create table solve_report_complain
(
	solve_rep_com_id int(10) not null auto_increment
    primary key,
	repair_rec_id int(10) null,
	type varchar(10) null,
	community varchar(1) null,
	building_number int(10) null,
	unit_number int(10) null,
	room_number int(10) null,
	content varchar(50) null,
	progress varchar(50) null,
	result varchar(10) null,
	season varchar(10) null,
	date timestamp null,
	constraint solve_report_complain_ibfk_1
		foreign key (repair_rec_id) references repair_record (repair_rec_id)
) default charset utf8
;

create index repair_rec_id
	on solve_report_complain (repair_rec_id)
;



create table solve_report_repair
(
	solve_report_id int(10) not null auto_increment
    primary key,
	repair_rec_id int(10) null,
	date timestamp default CURRENT_TIMESTAMP not null,
	community varchar(1) null,
	building_number int(10) null,
	unit_number int(10) null,
	room_number int(10) null,
	report_type varchar(50) null,
	cause varchar(50) null,
	season varchar(10) null,
	constraint solve_report_repair_ibfk_1
		foreign key (repair_rec_id) references repair_record (repair_rec_id)
) default charset utf8
;

create index repair_rec_id
	on solve_report_repair (repair_rec_id)
;

create table temporary_parking_record
(
	temp_park_rec_id int(10) auto_increment
		primary key,
	parking_id int(10) null,
	car_id varchar(10) null,
	is_parking varchar(1) null,
	begin_time timestamp default CURRENT_TIMESTAMP not null,
	end_time timestamp default '0000-00-00 00:00:00' not null,
	fee decimal(10,2) null,
	constraint temporary_parking_record_ibfk_1
		foreign key (parking_id) references parking_lot (parking_id)
) default charset utf8
;

create index parking_id
	on temporary_parking_record (parking_id)
;

create table vacancy
(
	vac_id int(10) auto_increment
		primary key,
	community varchar(10) not null,
	building_number varchar(10) not null,
	unit_number varchar(10) null,
	room_number varchar(10) null
) default charset utf8
;

