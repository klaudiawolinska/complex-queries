CREATE TABLE users
(
    log_date        date,
    user_account_id integer,
    action_type     varchar(32),
    account_type    varchar(16),
    user_level      varchar(16)
);

INSERT INTO users VALUES ('2020-02-15', 111, 'user account created', 'free (basic)', 'beginner');
INSERT INTO users VALUES ('2020-02-18', 111, 'user account updated', 'trial', NULL);
INSERT INTO users VALUES ('2020-02-25', 111, 'user account updated', NULL, 'contributor');
INSERT INTO users VALUES ('2020-03-01', 111, 'user account updated', 'premium', NULL);
INSERT INTO users VALUES ('2020-03-02', 111, 'user account updated', NULL, 'expert');
INSERT INTO users VALUES ('2020-03-06', 111, 'user account deleted', NULL, NULL);
INSERT INTO users VALUES ('2020-02-19', 222, 'user account created', 'free (basic)', 'beginner');
INSERT INTO users VALUES ('2020-03-01', 333, 'user account created', 'free (basic)', 'beginner');
INSERT INTO users VALUES ('2020-03-04', 333, 'user account deleted', NULL, NULL);
