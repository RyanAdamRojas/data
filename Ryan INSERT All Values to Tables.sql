-- SQL Value Insertion Statements

-- Report (id,fid,time_generated,year,total_hrs,)
insert into report
values (1, 1, 2023);

insert into report
values (2, 2, 2023);

insert into report
values (3, 3, 2024);

insert into report
values (4, 4, 2023);

insert into report
values (5, 5, 2023);

insert into report
values (6, 1, 2024);


-- Manages_Report (fid, rid)
insert into manages_report
values (1, 1);

insert into manages_report
values (2, 2);

insert into manages_report
values (3, 3);

insert into manages_report
values (4, 4);

insert into manages_report
values (5, 5);

insert into manages_report
values (6, 6);


-- Project (name, num_stu, f_commitment, start_date, end_date)
insert into project
values ('AI Research', 5, '10 hours per week', '2024-01-01', '2024-12-31');

insert into project
values ('Quantum Computing', 3, '15 hours per week', '2024-03-01', '2025-02-28');

insert into project
values ('Machine Learning in Healthcare', 8, '20 hours per week', '2024-05-01', '2025-04-30');

insert into project
values ('Blockchain Development', 4, '12 hours per week', '2024-02-01', '2024-11-30');

insert into project
values ('Cybersecurity Analysis', 6, '18 hours per week', '2024-04-01', '2025-03-31');

insert into project
values ('Natural Language Processing', 7, '25 hours per week', '2024-06-01', '2025-05-31');


-- Manages Project (fid, p_name)
insert into manages_project
values (1, 'AI Research');

insert into manages_project
values (2, 'Quantum Computing');

insert into manages_project
values (3, 'Machine Learning in Healthcare');

insert into manages_project
values (4, 'Blockchain Development');

insert into manages_project
values (5, 'Cybersecurity Analysis');

insert into manages_project
values (6, 'Natural Language Processing');


-- Funding (trans_id, source, amount)
insert into funding
values ('AI Research', 'National Science Foundation', 25000.00);

insert into funding
values ('Quantum Computing', 'Tech Innovations Fund', 30000.00);

insert into funding
values ('Machine Learning in Healthcare', 'Healthcare Research Initiative', 50000.00);

insert into funding
values ('Blockchain Development', 'Gates Science Foundation', 100000.00);

insert into funding
values ('Cybersecurity Analysis', 'Central Intelligence Agency', 90000.00);

insert into funding
values ('Natural Language Processing', 'Y-Combinator', 75000.00);