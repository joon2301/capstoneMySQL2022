#초기 데이터 추가
#사람 추가
insert into users values("test1","1234","test1@email.com");
insert into users values("test2","1234","test2@email.com");
insert into users values("test3","1234","test3@email.com");
insert into users values("test4","1234","test4@email.com");
insert into users values("test5","1234","test5@email.com");
#브레인 티저 추가
insert into brainTeaser Values(1,"teaser1","category1","test1","2022-03-01 12:00:00");
insert into brainTeaser Values(2,"teaser2","category1","test2","2022-03-02 12:05:00");
insert into brainTeaser Values(3,"teaser3","category2","test3","2022-03-03 12:10:00");
insert into brainTeaser Values(4,"teaser4","category2","test4","2022-03-04 12:15:00");
insert into brainTeaser Values(5,"teaser5","category3","test5","2022-03-05 12:20:00");
#더미 답안 추가 (일부러 2번에 2개임)
insert into teaserAnswer values(1,"test1",1,"answer1","2022-03-01 12:30:00 ");
insert into teaserAnswer values(2,"test2",2,"answer2","2022-03-02 12:30:00");
insert into teaserAnswer values(3,"test3",2,"answer3","2022-03-02 12:30:00");
insert into teaserAnswer values(4,"test4",3,"answer4","2022-03-05 12:30:00");
insert into teaserAnswer values(5,"test5",4,"answer5","2022-03-06 12:30:00");
#답글 좋아요 추가
insert into Answer_User_likes values("test1","1");
insert into Answer_User_likes values("test1","2");
insert into Answer_User_likes values("test1","3");
insert into Answer_User_likes values("test2","2");
insert into Answer_User_likes values("test2","4");
insert into Answer_User_likes values("test3","1");
insert into Answer_User_likes values("test3","3");
insert into Answer_User_likes values("test3","5");
insert into Answer_User_likes values("test4","4");
insert into Answer_User_likes values("test5","5");


