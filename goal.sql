-- 매니저 목표진척: 목표 명단(취합) + 실적(집계현황) 저장 테이블 (로그인한 사람만 보기/추가/수정/삭제)
create table if not exists goal_targets (
  code text not null, tier text not null,
  branch text default '', branch_head text default '', manager text default '',
  agency text default '', name text default '', note text default '',
  primary key (code, tier)
);
create table if not exists goal_perf (
  code text primary key, perf numeric default 0, cnt int default 0
);
create table if not exists goal_meta (
  id text primary key, updated_at timestamptz default now(), updated_by text default '', file_name text default '',
  target_rows int default 0, perf_rows int default 0
);
alter table goal_targets enable row level security;
alter table goal_perf enable row level security;
alter table goal_meta enable row level security;
drop policy if exists "gt all" on goal_targets;
drop policy if exists "gp all" on goal_perf;
drop policy if exists "gm all" on goal_meta;
create policy "gt all" on goal_targets for all to authenticated using (true) with check (true);
create policy "gp all" on goal_perf for all to authenticated using (true) with check (true);
create policy "gm all" on goal_meta for all to authenticated using (true) with check (true);
do $$ begin alter publication supabase_realtime add table goal_meta; exception when others then null; end $$;

-- 센터장 매핑 (매니저코칭노트 명단과 별개로 목표진척에서 센터장별 보기를 하기 위한 표)
create table if not exists goal_centers (
  branch_no int not null, manager text not null, center text not null default '',
  primary key (branch_no, manager)
);
alter table goal_centers enable row level security;
drop policy if exists "gc all" on goal_centers;
create policy "gc all" on goal_centers for all to authenticated using (true) with check (true);
insert into goal_centers (branch_no, manager, center) values
(10,'우옥주','홍영미'),
(10,'김보희','홍영미'),
(10,'오현옥','홍영미'),
(10,'이진이','홍영미'),
(10,'최서진','홍영미'),
(11,'김예지','조소현'),
(11,'고미란','조소현'),
(11,'이도희','조소현'),
(11,'이미라','조소현'),
(11,'조금희','조소현'),
(13,'김다경','이은정'),
(13,'김미나','이은정'),
(13,'김수지','이은정'),
(13,'조경애','이은정'),
(13,'허정은','이은정'),
(14,'윤미연','이은정'),
(14,'이순화','이은정'),
(14,'고인자','이은정'),
(14,'박지현','이은정'),
(14,'박현정','이은정'),
(16,'김찬주','김미송'),
(16,'박민수','김미송'),
(16,'전수지','김미송'),
(16,'채은교','김미송'),
(1,'안덕기','조소현'),
(1,'차윤정','조소현'),
(1,'고은채','조소현'),
(1,'곽은선','조소현'),
(1,'김빛나','조소현'),
(1,'김춘식','조소현'),
(1,'변지은','조소현'),
(1,'안수빈','조소현'),
(1,'이영미','조소현'),
(1,'이채연','조소현'),
(1,'이혜지','조소현'),
(1,'정복과','조소현'),
(2,'안용성','홍영미'),
(2,'함지윤','홍영미'),
(2,'홍은경','홍영미'),
(2,'김선영','홍영미'),
(2,'김선우','홍영미'),
(2,'김이연','홍영미'),
(2,'손호균','홍영미'),
(2,'송민주','홍영미'),
(2,'이학영','홍영미'),
(2,'정민이','홍영미'),
(2,'정영하','홍영미'),
(3,'김미애','김미송'),
(3,'도현미','김미송'),
(3,'윤현진','김미송'),
(3,'김인숙','김미송'),
(3,'이우리','김미송'),
(3,'이지숙','김미송'),
(3,'진선미','김미송'),
(4,'김애진','김미송'),
(4,'이여름','김미송'),
(4,'이인실','김미송'),
(4,'임경하','김미송'),
(4,'전은경','김미송'),
(4,'최란숙','김미송'),
(5,'김미란','이소윤'),
(5,'남하영','이소윤'),
(5,'오혜정','이소윤'),
(5,'권하린','이소윤'),
(5,'김채이','이소윤'),
(5,'김하나','이소윤'),
(5,'서수진','이소윤'),
(5,'이영임','이소윤'),
(5,'이옥선','이소윤'),
(5,'이진아','이소윤'),
(5,'주진숙','이소윤'),
(5,'황가현','이소윤'),
(6,'박연진','홍영미'),
(6,'신하은','이은정'),
(6,'유성현','홍영미'),
(6,'조화원','홍영미'),
(6,'홍지예','홍영미'),
(6,'이규익','이은정'),
(6,'이한솔','이은정'),
(6,'김해인','홍영미'),
(6,'나영은','이은정'),
(6,'양채은','홍영미'),
(6,'오은미','이은정'),
(6,'윤주연','이은정'),
(6,'이숙','홍영미'),
(6,'이해달','이은정'),
(6,'최유리','홍영미'),
(7,'김미용','이소윤'),
(7,'노소희','이소윤'),
(7,'방미정','이소윤'),
(7,'임지현','이소윤'),
(7,'최샛별','이소윤'),
(7,'김광미','이소윤'),
(7,'김소형','이소윤'),
(7,'박현숙','이소윤'),
(7,'이은애','이소윤'),
(7,'이정연','이소윤'),
(7,'정인선','이소윤'),
(7,'조예진','이소윤'),
(7,'홍지혜','이소윤'),
(8,'전은지','허은재'),
(8,'김하랑','허은재'),
(8,'김유진','허은재'),
(8,'김주영','허은재'),
(8,'박미경','허은재'),
(8,'손화진','허은재'),
(8,'오은희','허은재'),
(8,'원지현','허은재'),
(8,'이소영','허은재'),
(8,'이영주','허은재'),
(8,'이자영','허은재'),
(8,'장다경','허은재'),
(8,'정금빛','허은재'),
(9,'홍혁','허은재'),
(9,'박유나','허은재'),
(9,'서영란','허은재'),
(9,'신지안','허은재'),
(9,'이은미','허은재'),
(9,'이현숙','허은재'),
(9,'장미숙','허은재'),
(9,'진달래','허은재')
on conflict (branch_no, manager) do update set center = excluded.center;
