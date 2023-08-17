create table if not exists football.position(
    id smallint not null
        primary key,
    name text not null unique
);

create table if not exists football.national_team(
    id varchar(255) not null
        primary key,
    name text not null unique,
    coach text
);

create table if not exists football.club(
    id varchar(255) not null
        primary key,
    name text not null,
    league varchar(255) not null,
    stadium varchar(50)
);

create table if not exists football.championship(
    id varchar(255) not null
    primary key,
    name text not null unique
);

create table if not exists football.player(
    id varchar(255) not null
            primary key,
    name text not null,
    ages smallint not null,
    citizenship varchar(3) not null,
    position smallint not null
        constraint fk_position_position_id
            references football.position,
    national_team varchar(255)
        constraint fk_national_team_national_team_id
            references football.national_team,
    club varchar(255)
        constraint fk_club_club_id
            references football.club
);

create table if not exists football.cup(
    id varchar(255) not null
        primary key,
    name varchar(20) not null,
    year date not null,
    team varchar(255) not null,
    constraint fk_club_club_id foreign key (team) references football.club (id),
    constraint fk_national_team_national_team_id foreign key (team) references football.national_team (id)
);

alter table football.cup
add constraint uq_name_year unique(name, year, team);


create table if not exists football.championship_team(
    team_id varchar(255),
    championship_id varchar(255),
    primary key (team_id, championship_id),
    foreign key(team_id) references football.club(id),
    foreign key(team_id) references football.national_team(id),
    foreign key(championship_id) references football.championship(id)
);