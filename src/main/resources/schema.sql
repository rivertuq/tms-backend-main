DROP TABLE IF EXISTS users, roles, users_roles, tasks CASCADE;

CREATE TABLE IF NOT EXISTS users (
    id              BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    username        VARCHAR(30) NOT NULL UNIQUE,
    password        VARCHAR(80) NOT NULL,
    email           VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS roles (
    id              INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name            VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS users_roles (
    user_id         BIGINT  NOT NULL,
    role_id         INT     NOT NULL,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tasks (
    id              BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    header          VARCHAR(80) NOT NULL,
    description     VARCHAR(500) NOT NULL,
    status          VARCHAR(11) NOT NULL,
    priority        VARCHAR(50) NOT NULL,
    author_id       BIGINT NOT NULL,
    executor_id     BIGINT,
    FOREIGN KEY (author_id)   REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (executor_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS comments (
    id          BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    text        VARCHAR(250)    NOT NULL,
    author_id   BIGINT          NOT NULL,
    task_id     BIGINT          NOT NULL,
    FOREIGN KEY (author_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (task_id)   REFERENCES tasks (id) ON DELETE CASCADE
);