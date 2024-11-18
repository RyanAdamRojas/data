call insert_report(7, 7, '05:30:00', 2023, 50);

call insert_manages_report(7, 7);

call insert_project(
    'Self-Driving Cars',
    7,
    12,
    '20 hours per week',
    '2021-12-01',
    '2028-09-01'
);

call insert_manages_project(7, 'Self-Driving Cars');

call insert_funding(7, 'Tesla-Automotive', 1000000);