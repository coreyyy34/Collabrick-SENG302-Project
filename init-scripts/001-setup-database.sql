-- sprint 3
create sequence renovation_user_seq start with 1 increment by 50 nocache;
create table authority (authority_id bigint not null auto_increment, user_id bigint, role varchar(255), primary key (authority_id)) engine=InnoDB;
create table forgotten_password_token (expiry_date datetime(6) not null, user_id bigint not null, id binary(16) not null, primary key (id)) engine=InnoDB;
create table renovation (is_public bit, created_timestamp datetime(6), id bigint not null auto_increment, user_id bigint not null, description varchar(600) not null, city varchar(255), country varchar(255), name varchar(255) not null, postcode varchar(255), region varchar(255), street_address varchar(255), suburb varchar(255), primary key (id)) engine=InnoDB;
create table renovation_user (activated bit, created_timestamp datetime(6), id bigint not null, city varchar(255), country varchar(255), email varchar(255) not null, fname varchar(255) not null, image varchar(255), lname varchar(255) not null, password varchar(255) not null, postcode varchar(255), region varchar(255), street_address varchar(255), suburb varchar(255), primary key (id)) engine=InnoDB;
create table room (id bigint not null auto_increment, renovation_id bigint not null, name varchar(255) not null, primary key (id)) engine=InnoDB;
create table tag (renovation bigint not null, tag varchar(255) not null, primary key (renovation, tag)) engine=InnoDB;
create table task (due_date date, id bigint not null auto_increment, renovation_id bigint not null, description varchar(600) not null, icon_file_name varchar(255) not null, name varchar(255) not null, state enum ('NOT_STARTED','IN_PROGRESS','BLOCKED','COMPLETED','CANCELLED') not null, primary key (id)) engine=InnoDB;
create table task_room (room_id bigint not null, task_id bigint not null) engine=InnoDB;
create table verification_token (expiry_date datetime(6) not null, id bigint not null auto_increment, user_id bigint not null, token varchar(255) not null, primary key (id)) engine=InnoDB;
alter table forgotten_password_token add constraint UK_qnr9y2kxklc1ovc7tmf8mq2rs unique (user_id);
alter table verification_token add constraint UK_q6jibbenp7o9v6tq178xg88hg unique (user_id);
alter table verification_token add constraint UK_p678btf3r9yu6u8aevyb4ff0m unique (token);
alter table authority add constraint FKkjkd05i1g2bewgkh7u4yh606x foreign key (user_id) references renovation_user (id);
alter table forgotten_password_token add constraint FKogk6u6byc7biax27llb98ebme foreign key (user_id) references renovation_user (id);
alter table renovation add constraint FKayhwx6uv9ku1rohaog4phuloj foreign key (user_id) references renovation_user (id);
alter table room add constraint FK4bct9mv40d3hbre7ccqdcqy1q foreign key (renovation_id) references renovation (id);
alter table tag add constraint FK1q79k4wif1at9kcpsvrnja70d foreign key (renovation) references renovation (id);
alter table task add constraint FK82rswqeoy31roi3ay3p9ksha6 foreign key (renovation_id) references renovation (id);
alter table task_room add constraint FKfv55x16kojpuwygprobd0wpak foreign key (room_id) references room (id);
alter table task_room add constraint FK5ry8x17wkej43edtjl5drueav foreign key (task_id) references task (id);
alter table verification_token add constraint FKltvrqq324ejfqicl9qk7hylc0 foreign key (user_id) references renovation_user (id);


-- sprint 4
CREATE SEQUENCE expense_seq INCREMENT BY 50 START WITH 1;

CREATE TABLE expense
(
    id               BIGINT       NOT NULL,
    expense_name     VARCHAR(255) NOT NULL,
    expense_category VARCHAR(255) NOT NULL,
    expense_cost     DECIMAL      NOT NULL,
    expense_date     date         NOT NULL,
    task_id          BIGINT       NOT NULL,
    CONSTRAINT pk_expense PRIMARY KEY (id)
);

CREATE TABLE invitation
(
    id            UUID   NOT NULL,
    user_id       BIGINT       NULL,
    email         VARCHAR(255) NULL,
    renovation_id BIGINT       NOT NULL,
    resolved      BIT(1)       NULL,
    CONSTRAINT pk_invitation PRIMARY KEY (id)
);

CREATE TABLE renovation_member
(
    `role`        SMALLINT NOT NULL,
    renovation_id BIGINT   NOT NULL,
    user_id       BIGINT   NOT NULL,
    CONSTRAINT pk_renovationmember PRIMARY KEY (renovation_id, user_id)
);

ALTER TABLE forgotten_password_token
    ADD CONSTRAINT uc_forgottenpasswordtoken_user UNIQUE (user_id);

ALTER TABLE verification_token
    ADD CONSTRAINT uc_verificationtoken_token UNIQUE (token);

ALTER TABLE verification_token
    ADD CONSTRAINT uc_verificationtoken_user UNIQUE (user_id);

CREATE UNIQUE INDEX IX_pk_tag ON tag (tag, renovation);

ALTER TABLE authority
    ADD CONSTRAINT FK_AUTHORITY_ON_USER FOREIGN KEY (user_id) REFERENCES renovation_user (id);

ALTER TABLE expense
    ADD CONSTRAINT FK_EXPENSE_ON_TASK FOREIGN KEY (task_id) REFERENCES task (id);

ALTER TABLE forgotten_password_token
    ADD CONSTRAINT FK_FORGOTTENPASSWORDTOKEN_ON_USER FOREIGN KEY (user_id) REFERENCES renovation_user (id);

ALTER TABLE invitation
    ADD CONSTRAINT FK_INVITATION_ON_RENOVATION FOREIGN KEY (renovation_id) REFERENCES renovation (id);

ALTER TABLE invitation
    ADD CONSTRAINT FK_INVITATION_ON_USER FOREIGN KEY (user_id) REFERENCES renovation_user (id);

ALTER TABLE renovation_member
    ADD CONSTRAINT FK_RENOVATIONMEMBER_ON_RENOVATION FOREIGN KEY (renovation_id) REFERENCES renovation (id);

ALTER TABLE renovation_member
    ADD CONSTRAINT FK_RENOVATIONMEMBER_ON_USER FOREIGN KEY (user_id) REFERENCES renovation_user (id);

ALTER TABLE renovation
    ADD CONSTRAINT FK_RENOVATION_ON_USER FOREIGN KEY (user_id) REFERENCES renovation_user (id);

ALTER TABLE room
    ADD CONSTRAINT FK_ROOM_ON_RENOVATION FOREIGN KEY (renovation_id) REFERENCES renovation (id);

ALTER TABLE tag
    ADD CONSTRAINT FK_TAG_ON_RENOVATION FOREIGN KEY (renovation) REFERENCES renovation (id);

ALTER TABLE task
    ADD CONSTRAINT FK_TASK_ON_RENOVATION FOREIGN KEY (renovation_id) REFERENCES renovation (id);

ALTER TABLE verification_token
    ADD CONSTRAINT FK_VERIFICATIONTOKEN_ON_USER FOREIGN KEY (user_id) REFERENCES renovation_user (id);

ALTER TABLE task_room
    ADD CONSTRAINT fk_task_room_on_room FOREIGN KEY (room_id) REFERENCES room (id);

ALTER TABLE task_room
    ADD CONSTRAINT fk_task_room_on_task FOREIGN KEY (task_id) REFERENCES task (id);

ALTER TABLE task
DROP COLUMN state;

ALTER TABLE task
    ADD state VARCHAR(255) NOT NULL;

-- sprint 5
CREATE TABLE budget
(
    budget_id                   BIGINT AUTO_INCREMENT NOT NULL,
    renovation_id               BIGINT NOT NULL,
    miscellaneous_budget        DECIMAL NULL,
    material_budget             DECIMAL NULL,
    labour_budget               DECIMAL NULL,
    equipment_budget            DECIMAL NULL,
    professional_service_budget DECIMAL NULL,
    permit_budget               DECIMAL NULL,
    cleanup_budget              DECIMAL NULL,
    delivery_budget             DECIMAL NULL,
    CONSTRAINT pk_budget PRIMARY KEY (budget_id)
);

CREATE TABLE chat_channel
(
    id            BIGINT AUTO_INCREMENT NOT NULL,
    name          VARCHAR(255) NOT NULL,
    renovation_id BIGINT NULL,
    CONSTRAINT pk_chatchannel PRIMARY KEY (id)
);

CREATE TABLE chat_channel_member
(
    channel_id BIGINT NOT NULL,
    member_id  BIGINT NOT NULL
);

CREATE TABLE chat_message
(
    id         BIGINT AUTO_INCREMENT NOT NULL,
    content    TEXT NOT NULL,
    timestamp  datetime     NOT NULL,
    channel_id BIGINT NULL,
    sender_id  BIGINT NULL,
    CONSTRAINT pk_chatmessage PRIMARY KEY (id)
)CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

ALTER TABLE invitation
    ADD accepted_pending_registration BIT(1) DEFAULT 0;

ALTER TABLE invitation
    ADD expiry_date datetime DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE invitation
    ADD invitation_status SMALLINT DEFAULT 3;

ALTER TABLE invitation
    MODIFY expiry_date datetime NOT NULL;

ALTER TABLE budget
    ADD CONSTRAINT uc_budget_renovation UNIQUE (renovation_id);

ALTER TABLE budget
    ADD CONSTRAINT FK_BUDGET_ON_RENOVATION FOREIGN KEY (renovation_id) REFERENCES renovation (id);

ALTER TABLE chat_channel
    ADD CONSTRAINT FK_CHATCHANNEL_ON_RENOVATION FOREIGN KEY (renovation_id) REFERENCES renovation (id);

ALTER TABLE chat_message
    ADD CONSTRAINT FK_CHATMESSAGE_ON_CHANNEL FOREIGN KEY (channel_id) REFERENCES chat_channel (id);

ALTER TABLE chat_message
    ADD CONSTRAINT FK_CHATMESSAGE_ON_SENDER FOREIGN KEY (sender_id) REFERENCES renovation_user (id);

ALTER TABLE chat_channel_member
    ADD CONSTRAINT fk_chachamem_on_chat_channel FOREIGN KEY (channel_id) REFERENCES chat_channel (id);

ALTER TABLE chat_channel_member
    ADD CONSTRAINT fk_chachamem_on_user FOREIGN KEY (member_id) REFERENCES renovation_user (id);

ALTER TABLE invitation
DROP
COLUMN resolved;

-- sprint 6
CREATE TABLE IF NOT EXISTS SPRING_AI_CHAT_MEMORY (
    conversation_id VARCHAR(36) NOT NULL,
    content TEXT NOT NULL,
    type ENUM('USER', 'ASSISTANT', 'SYSTEM', 'TOOL') NOT NULL,
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX SPRING_AI_CHAT_MEMORY_CONVERSATION_ID_TIMESTAMP_IDX (conversation_id, timestamp)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE chat_mention
(
    id                BIGINT AUTO_INCREMENT NOT NULL,
    message_id        BIGINT NULL,
    mentioned_user_id BIGINT NULL,
    start_position    INT NULL,
    end_position      INT NULL,
    seen              BIT(1) NULL,
    CONSTRAINT pk_chatmention PRIMARY KEY (id)
);

CREATE TABLE live_update
(
    id            BIGINT AUTO_INCREMENT NOT NULL,
    user_id       BIGINT NULL,
    renovation_id BIGINT       NOT NULL,
    timestamp     datetime     NOT NULL,
    task_id       BIGINT NULL,
    expense_id    BIGINT NULL,
    invitation_id UUID            NULL,
    activity_type VARCHAR(255) NOT NULL,
    CONSTRAINT pk_liveupdate PRIMARY KEY (id)
);

CREATE TABLE recently_accessed_renovation
(
    time_accessed datetime NULL,
    renovation_id BIGINT NOT NULL,
    user_id       BIGINT NOT NULL,
    CONSTRAINT pk_recentlyaccessedrenovation PRIMARY KEY (renovation_id, user_id)
);

ALTER TABLE renovation
    ADD allow_brickai BIT(1) NOT NULL DEFAULT b'1';

ALTER TABLE renovation_user
    ADD allow_brickaichat_access BIT(1) NOT NULL DEFAULT b'1';

ALTER TABLE chat_mention
    ADD CONSTRAINT FK_CHATMENTION_ON_MENTIONED_USER FOREIGN KEY (mentioned_user_id) REFERENCES renovation_user (id);

ALTER TABLE chat_mention
    ADD CONSTRAINT FK_CHATMENTION_ON_MESSAGE FOREIGN KEY (message_id) REFERENCES chat_message (id);

ALTER TABLE live_update
    ADD CONSTRAINT FK_LIVEUPDATE_ON_EXPENSE FOREIGN KEY (expense_id) REFERENCES expense (id);

ALTER TABLE live_update
    ADD CONSTRAINT FK_LIVEUPDATE_ON_INVITATION FOREIGN KEY (invitation_id) REFERENCES invitation (id);

ALTER TABLE live_update
    ADD CONSTRAINT FK_LIVEUPDATE_ON_RENOVATION FOREIGN KEY (renovation_id) REFERENCES renovation (id);

ALTER TABLE live_update
    ADD CONSTRAINT FK_LIVEUPDATE_ON_TASK FOREIGN KEY (task_id) REFERENCES task (id);

ALTER TABLE live_update
    ADD CONSTRAINT FK_LIVEUPDATE_ON_USER FOREIGN KEY (user_id) REFERENCES renovation_user (id);

ALTER TABLE recently_accessed_renovation
    ADD CONSTRAINT FK_RECENTLYACCESSEDRENOVATION_ON_RENOVATION FOREIGN KEY (renovation_id) REFERENCES renovation (id);

ALTER TABLE recently_accessed_renovation
    ADD CONSTRAINT FK_RECENTLYACCESSEDRENOVATION_ON_USER FOREIGN KEY (user_id) REFERENCES renovation_user (id);