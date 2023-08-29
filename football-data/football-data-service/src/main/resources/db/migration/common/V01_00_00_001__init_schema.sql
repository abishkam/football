create type football.position_type as enum(
    'GK',
    'CB',
    'LB',
    'RB',
    'LWB',
    'RWB',
    'CDM',
    'CM',
    'LM',
    'RM',
    'CAM',
    'ST',
    'CF',
    'LW',
    'RW'
);

create table if not exists football.national_team(
    id uuid not null
        primary key,
    name text not null unique,
    coach text
);

create table if not exists football.club(
    id uuid not null
        primary key,
    name text not null unique,
    league varchar(255) not null,
    stadium varchar(50)
);

create table if not exists football.championship(
    id uuid not null
        primary key,
    name text not null unique
);

create table if not exists football.player(
    id uuid not null
        primary key,
    name text not null,
    ages date not null,
    citizenship varchar(3) not null,
    player_position football.position_type not null,
    national_team_id uuid
        constraint fk_player_national_team_id
            references football.national_team,
    club_id uuid
        constraint fk_player_club_id
            references football.club
);

create table if not exists football.cup(
    id uuid not null
        primary key,
    name text not null unique,
    year date not null,
    club_id uuid
        constraint fk_cup_club_id
            references football.club,
    national_team_id uuid
        constraint fk_cup_national_team_id
            references football.national_team
);
alter table football.cup
    add constraint uq_name_year unique(name, year, club_id, national_team_id);

-- Поменял many_to_many на many_to_one
create table if not exists football.championship_team(
    id uuid not null
        primary key,
    club_id uuid
        constraint fk_championship_team_club_id
            references football.club,
    national_team_id uuid
        constraint fk_championship_team_nt_id
            references football.national_team,
    championship_id uuid
        constraint fk_championship_team_championship_id
            references football.championship
);
