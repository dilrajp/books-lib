-- public.authors definition

-- Drop table

-- DROP TABLE public.authors;

CREATE TABLE public.authors (
	id bigserial NOT NULL,
	"name" varchar(255) NOT NULL,
	email varchar(255) NOT NULL,
	created_at timestamp(0) NULL,
	updated_at timestamp(0) NULL,
	CONSTRAINT authors_email_unique UNIQUE (email),
	CONSTRAINT authors_pkey PRIMARY KEY (id)
);


-- public."cache" definition

-- Drop table

-- DROP TABLE public."cache";

CREATE TABLE public."cache" (
	"key" varchar(255) NOT NULL,
	value text NOT NULL,
	expiration int4 NOT NULL,
	CONSTRAINT cache_pkey PRIMARY KEY (key)
);


-- public.cache_locks definition

-- Drop table

-- DROP TABLE public.cache_locks;

CREATE TABLE public.cache_locks (
	"key" varchar(255) NOT NULL,
	"owner" varchar(255) NOT NULL,
	expiration int4 NOT NULL,
	CONSTRAINT cache_locks_pkey PRIMARY KEY (key)
);


-- public.categories definition

-- Drop table

-- DROP TABLE public.categories;

CREATE TABLE public.categories (
	id bigserial NOT NULL,
	"name" varchar(255) NOT NULL,
	description text NULL,
	created_at timestamp(0) NULL,
	updated_at timestamp(0) NULL,
	CONSTRAINT categories_pkey PRIMARY KEY (id)
);


-- public.failed_jobs definition

-- Drop table

-- DROP TABLE public.failed_jobs;

CREATE TABLE public.failed_jobs (
	id bigserial NOT NULL,
	"uuid" varchar(255) NOT NULL,
	"connection" text NOT NULL,
	queue text NOT NULL,
	payload text NOT NULL,
	"exception" text NOT NULL,
	failed_at timestamp(0) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	CONSTRAINT failed_jobs_pkey PRIMARY KEY (id),
	CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid)
);


-- public.job_batches definition

-- Drop table

-- DROP TABLE public.job_batches;

CREATE TABLE public.job_batches (
	id varchar(255) NOT NULL,
	"name" varchar(255) NOT NULL,
	total_jobs int4 NOT NULL,
	pending_jobs int4 NOT NULL,
	failed_jobs int4 NOT NULL,
	failed_job_ids text NOT NULL,
	"options" text NULL,
	cancelled_at int4 NULL,
	created_at int4 NOT NULL,
	finished_at int4 NULL,
	CONSTRAINT job_batches_pkey PRIMARY KEY (id)
);


-- public.jobs definition

-- Drop table

-- DROP TABLE public.jobs;

CREATE TABLE public.jobs (
	id bigserial NOT NULL,
	queue varchar(255) NOT NULL,
	payload text NOT NULL,
	attempts int2 NOT NULL,
	reserved_at int4 NULL,
	available_at int4 NOT NULL,
	created_at int4 NOT NULL,
	CONSTRAINT jobs_pkey PRIMARY KEY (id)
);
CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


-- public.migrations definition

-- Drop table

-- DROP TABLE public.migrations;

CREATE TABLE public.migrations (
	id serial4 NOT NULL,
	migration varchar(255) NOT NULL,
	batch int4 NOT NULL,
	CONSTRAINT migrations_pkey PRIMARY KEY (id)
);


-- public.password_reset_tokens definition

-- Drop table

-- DROP TABLE public.password_reset_tokens;

CREATE TABLE public.password_reset_tokens (
	email varchar(255) NOT NULL,
	"token" varchar(255) NOT NULL,
	created_at timestamp(0) NULL,
	CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email)
);


-- public.sessions definition

-- Drop table

-- DROP TABLE public.sessions;

CREATE TABLE public.sessions (
	id varchar(255) NOT NULL,
	user_id int8 NULL,
	ip_address varchar(45) NULL,
	user_agent text NULL,
	payload text NOT NULL,
	last_activity int4 NOT NULL,
	CONSTRAINT sessions_pkey PRIMARY KEY (id)
);
CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);
CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


-- public.users definition

-- Drop table

-- DROP TABLE public.users;

CREATE TABLE public.users (
	id bigserial NOT NULL,
	"name" varchar(255) NOT NULL,
	email varchar(255) NOT NULL,
	email_verified_at timestamp(0) NULL,
	"password" varchar(255) NOT NULL,
	remember_token varchar(100) NULL,
	created_at timestamp(0) NULL,
	updated_at timestamp(0) NULL,
	CONSTRAINT users_email_unique UNIQUE (email),
	CONSTRAINT users_pkey PRIMARY KEY (id)
);


-- public.books definition

-- Drop table

-- DROP TABLE public.books;

CREATE TABLE public.books (
	id bigserial NOT NULL,
	title varchar(255) NOT NULL,
	author_id int8 NOT NULL,
	description text NULL,
	isbn varchar(255) NOT NULL,
	published bool DEFAULT false NOT NULL,
	created_at timestamp(0) NULL,
	updated_at timestamp(0) NULL,
	CONSTRAINT books_isbn_unique UNIQUE (isbn),
	CONSTRAINT books_pkey PRIMARY KEY (id),
	CONSTRAINT books_author_id_foreign FOREIGN KEY (author_id) REFERENCES public.authors(id) ON DELETE CASCADE
);


-- public.book_category definition

-- Drop table

-- DROP TABLE public.book_category;

CREATE TABLE public.book_category (
	id bigserial NOT NULL,
	book_id int8 NOT NULL,
	category_id int8 NOT NULL,
	created_at timestamp(0) NULL,
	updated_at timestamp(0) NULL,
	CONSTRAINT book_category_pkey PRIMARY KEY (id),
	CONSTRAINT book_category_book_id_foreign FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE,
	CONSTRAINT book_category_category_id_foreign FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE
);