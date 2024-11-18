-- SQL Table Creation Statements
-- Report
create table report (
    ID int not null,
    FID int,
    Year year,
    primary key (ID)
) Engine = InnoDB;

-- Manages_Report
create table manages_report (
    FID int not null,
    RID int not null,
    primary key (FID, RID),
    foreign key (FID) references facultymember(FID) on update cascade on delete cascade,
    foreign key (RID) references report(ID) on update cascade on delete cascade
) Engine = InnoDB;

-- Project
create table project (
    Name char(255) not null unique,
    Num_Student_Researchers int,
    Faculty_Commitment char(50),
    Start_Date date,
    End_Date date,
    primary key (Name)
) Engine = InnoDB;

-- Manages_Project
create table manages_project (
    FID int not null,
    P_Name char(255) not null,
    primary key (FID, P_Name),
    foreign key (P_Name) references project(Name) on update cascade on delete cascade
) Engine = InnoDB;

-- Funding
create table funding (
    P_Name char(255) not null,
    Source char(255) not null,
    Amount decimal not null,
    primary key (P_Name, Source, Amount),
    foreign key (P_Name) references project(Name) on update cascade on delete cascade
) Engine = InnoDB;