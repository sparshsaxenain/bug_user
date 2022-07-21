
drop DATABASE bug_user;
create database bug_user;
use bug_user;

-- SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS; 
-- SET FOREIGN_KEY_CHECKS=0;   
-- SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;

create table bug_user.user(
    `id` int auto_increment,
    `media_id` int not null,
    `name` varchar(50) not null,
    primary key(`id`)
);


create table bug_user.project(
    `id` int AUTO_INCREMENT,
    `name` VARCHAR(50),
    primary key (`id`)
);

create table bug_user.bug(
    `id` INT AUTO_INCREMENT,
    `project_id` INT,
    `name` VARCHAR(45) not null,
    Constraint `FK_project_id_bug` FOREIGN KEY(`project_id`) REFERENCES bug_user.project(`id`),
    primary key(`id`)
);

create table bug_user.comment(
    `id` INT AUTO_INCREMENT,
    `bug_project_id` INT,
    `bug_id` INT,
    `text` text,
    primary key(`id`),
    Constraint `FK_bug_project_id` FOREIGN KEY(`bug_project_id`) REFERENCES bug_user.bug(`project_id`),
    Constraint `FK_bug_id` FOREIGN KEY(`bug_id`) REFERENCES bug_user.bug(`id`)
);

create table bug_user.media(
    `id` INT AUTO_INCREMENT,
    `user_id` INT,
    `path` VARCHAR(70) not null,
    `filetype` VARCHAR(20) not null,
    `filesize` DECIMAL(65,2),
    primary key(`id`),
    Constraint `FK_user_id_media` FOREIGN KEY(`user_id`) REFERENCES bug_user.user(`id`)
);

create table bug_user.project_has_user(
    `project_id` INT,
    `user_id` int ,
    `manger` TINYINT(1),
    Constraint `FK_user_id` FOREIGN key (`user_id`) REFERENCES bug_user.user(`id`),
    Constraint `FK_project_id` FOREIGN KEY(`project_id`) REFERENCES bug_user.project(`id`),
    primary key(`user_id`,`project_id`)
);

create table bug_user.bug_has_media(
    `bug_id` INT,
    `bug_project_id` INT,
    `media_id` INT,
    CONSTRAINT `FK_bug_id_media` FOREIGN KEY(`bug_id`) REFERENCES bug_user.bug(`id`),
    CONSTRAINT `FK_bug_project_id_media` FOREIGN KEY(`bug_project_id`) REFERENCES bug_user.project(`id`),
    CONSTRAINT `FK_media_id_media` FOREIGN KEY(`media_id`) REFERENCES bug_user.media(`id`),
    primary key(`bug_id`,`bug_project_id`,`media_id`)
);

create table bug_user.comment_has_media(
    `comment_id` INT,
    `comment_bug_project_id` INT,
    `comment_bug_id` INT,
    `media_id` INT,
    CONSTRAINT `FK_comment_id_has_media` FOREIGN KEY(`comment_id`) REFERENCES bug_user.comment(`id`),
    CONSTRAINT `FK_comment_bug_project_id` FOREIGN KEY(`comment_bug_project_id`) REFERENCES bug_user.comment(`bug_project_id`),
    CONSTRAINT `FK_comment_bug_id` FOREIGN KEY(`comment_bug_id`) REFERENCES bug_user.comment(`bug_id`),
    CONSTRAINT `FK_media_id_has_media` FOREIGN KEY(`media_id`) REFERENCES bug_user.media(`id`)
);

show tables;