
Copyright 2009 Jake Wheat

This file contains

> {-# OPTIONS_HADDOCK hide  #-}

> module Database.HsSqlPpp.AstInternals.Environment.DefaultTemplate1Environment
>     (defaultTemplate1Environment
>      ) where

> import Database.HsSqlPpp.AstInternals.Environment.EnvironmentInternal
> import Database.HsSqlPpp.AstInternals.TypeType

> defaultTemplate1Environment :: Environment
> defaultTemplate1Environment =
>    (\l -> case l of
>             Left x -> error $ show x
>             Right e -> e) $
>     updateEnvironment defaultEnvironment
>        [ EnvCreateScalar (
>            ScalarType "bool" )
>            "B"
>            True
>        , EnvCreateScalar (
>            ScalarType "bytea" )
>            "U"
>            False
>        , EnvCreateScalar (
>            ScalarType "char" )
>            "S"
>            False
>        , EnvCreateScalar (
>            ScalarType "name" )
>            "S"
>            False
>        , EnvCreateScalar (
>            ScalarType "int8" )
>            "N"
>            False
>        , EnvCreateScalar (
>            ScalarType "int2" )
>            "N"
>            False
>        , EnvCreateScalar (
>            ScalarType "int2vector" )
>            "A"
>            False
>        , EnvCreateScalar (
>            ScalarType "int4" )
>            "N"
>            False
>        , EnvCreateScalar (
>            ScalarType "regproc" )
>            "N"
>            False
>        , EnvCreateScalar (
>            ScalarType "text" )
>            "S"
>            True
>        , EnvCreateScalar (
>            ScalarType "oid" )
>            "N"
>            True
>        , EnvCreateScalar (
>            ScalarType "tid" )
>            "U"
>            False
>        , EnvCreateScalar (
>            ScalarType "xid" )
>            "U"
>            False
>        , EnvCreateScalar (
>            ScalarType "cid" )
>            "U"
>            False
>        , EnvCreateScalar (
>            ScalarType "oidvector" )
>            "A"
>            False
>        , EnvCreateScalar (
>            ScalarType "xml" )
>            "U"
>            False
>        , EnvCreateScalar (
>            ScalarType "point" )
>            "G"
>            False
>        , EnvCreateScalar (
>            ScalarType "lseg" )
>            "G"
>            False
>        , EnvCreateScalar (
>            ScalarType "path" )
>            "G"
>            False
>        , EnvCreateScalar (
>            ScalarType "box" )
>            "G"
>            False
>        , EnvCreateScalar (
>            ScalarType "polygon" )
>            "G"
>            False
>        , EnvCreateScalar (
>            ScalarType "line" )
>            "G"
>            False
>        , EnvCreateScalar (
>            ScalarType "float4" )
>            "N"
>            False
>        , EnvCreateScalar (
>            ScalarType "float8" )
>            "N"
>            True
>        , EnvCreateScalar (
>            ScalarType "abstime" )
>            "D"
>            False
>        , EnvCreateScalar (
>            ScalarType "reltime" )
>            "T"
>            False
>        , EnvCreateScalar (
>            ScalarType "tinterval" )
>            "T"
>            False
>        , EnvCreateScalar (
>            ScalarType "circle" )
>            "G"
>            False
>        , EnvCreateScalar (
>            ScalarType "money" )
>            "N"
>            False
>        , EnvCreateScalar (
>            ScalarType "macaddr" )
>            "U"
>            False
>        , EnvCreateScalar (
>            ScalarType "inet" )
>            "I"
>            True
>        , EnvCreateScalar (
>            ScalarType "cidr" )
>            "I"
>            False
>        , EnvCreateScalar (
>            ScalarType "aclitem" )
>            "U"
>            False
>        , EnvCreateScalar (
>            ScalarType "bpchar" )
>            "S"
>            False
>        , EnvCreateScalar (
>            ScalarType "varchar" )
>            "S"
>            False
>        , EnvCreateScalar (
>            ScalarType "date" )
>            "D"
>            False
>        , EnvCreateScalar (
>            ScalarType "time" )
>            "D"
>            False
>        , EnvCreateScalar (
>            ScalarType "timestamp" )
>            "D"
>            False
>        , EnvCreateScalar (
>            ScalarType "timestamptz" )
>            "D"
>            True
>        , EnvCreateScalar (
>            ScalarType "interval" )
>            "T"
>            True
>        , EnvCreateScalar (
>            ScalarType "timetz" )
>            "D"
>            False
>        , EnvCreateScalar (
>            ScalarType "bit" )
>            "V"
>            False
>        , EnvCreateScalar (
>            ScalarType "varbit" )
>            "V"
>            True
>        , EnvCreateScalar (
>            ScalarType "numeric" )
>            "N"
>            False
>        , EnvCreateScalar (
>            ScalarType "refcursor" )
>            "U"
>            False
>        , EnvCreateScalar (
>            ScalarType "regprocedure" )
>            "N"
>            False
>        , EnvCreateScalar (
>            ScalarType "regoper" )
>            "N"
>            False
>        , EnvCreateScalar (
>            ScalarType "regoperator" )
>            "N"
>            False
>        , EnvCreateScalar (
>            ScalarType "regclass" )
>            "N"
>            False
>        , EnvCreateScalar (
>            ScalarType "regtype" )
>            "N"
>            False
>        , EnvCreateScalar (
>            ScalarType "uuid" )
>            "U"
>            False
>        , EnvCreateScalar (
>            ScalarType "tsvector" )
>            "U"
>            False
>        , EnvCreateScalar (
>            ScalarType "gtsvector" )
>            "U"
>            False
>        , EnvCreateScalar (
>            ScalarType "tsquery" )
>            "U"
>            False
>        , EnvCreateScalar (
>            ScalarType "regconfig" )
>            "N"
>            False
>        , EnvCreateScalar (
>            ScalarType "regdictionary" )
>            "N"
>            False
>        , EnvCreateScalar (
>            ScalarType "txid_snapshot" )
>            "U"
>            False
>        , EnvCreateDomain (
>            DomainType "information_schema.cardinal_number" ) (
>            ScalarType "int4" )
>        , EnvCreateDomain (
>            DomainType "information_schema.character_data" ) (
>            ScalarType "varchar" )
>        , EnvCreateDomain (
>            DomainType "information_schema.sql_identifier" ) (
>            ScalarType "varchar" )
>        , EnvCreateDomain (
>            DomainType "information_schema.time_stamp" ) (
>            ScalarType "timestamptz" )
>        , EnvCreateCast (
>            ScalarType "int8" ) (
>            ScalarType "int2" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "int8" ) (
>            ScalarType "int4" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "int8" ) (
>            ScalarType "float4" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int8" ) (
>            ScalarType "float8" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int8" ) (
>            ScalarType "numeric" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int2" ) (
>            ScalarType "int8" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int2" ) (
>            ScalarType "int4" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int2" ) (
>            ScalarType "float4" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int2" ) (
>            ScalarType "float8" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int2" ) (
>            ScalarType "numeric" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "int8" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "int2" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "float4" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "float8" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "numeric" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "float4" ) (
>            ScalarType "int8" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "float4" ) (
>            ScalarType "int2" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "float4" ) (
>            ScalarType "int4" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "float4" ) (
>            ScalarType "float8" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "float4" ) (
>            ScalarType "numeric" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "float8" ) (
>            ScalarType "int8" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "float8" ) (
>            ScalarType "int2" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "float8" ) (
>            ScalarType "int4" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "float8" ) (
>            ScalarType "float4" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "float8" ) (
>            ScalarType "numeric" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "numeric" ) (
>            ScalarType "int8" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "numeric" ) (
>            ScalarType "int2" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "numeric" ) (
>            ScalarType "int4" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "numeric" ) (
>            ScalarType "float4" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "numeric" ) (
>            ScalarType "float8" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "bool" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "bool" ) (
>            ScalarType "int4" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int8" ) (
>            ScalarType "oid" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int2" ) (
>            ScalarType "oid" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "oid" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "oid" ) (
>            ScalarType "int8" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "oid" ) (
>            ScalarType "int4" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "oid" ) (
>            ScalarType "regproc" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "regproc" ) (
>            ScalarType "oid" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int8" ) (
>            ScalarType "regproc" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int2" ) (
>            ScalarType "regproc" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "regproc" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "regproc" ) (
>            ScalarType "int8" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "regproc" ) (
>            ScalarType "int4" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "regproc" ) (
>            ScalarType "regprocedure" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "regprocedure" ) (
>            ScalarType "regproc" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "oid" ) (
>            ScalarType "regprocedure" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "regprocedure" ) (
>            ScalarType "oid" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int8" ) (
>            ScalarType "regprocedure" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int2" ) (
>            ScalarType "regprocedure" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "regprocedure" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "regprocedure" ) (
>            ScalarType "int8" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "regprocedure" ) (
>            ScalarType "int4" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "oid" ) (
>            ScalarType "regoper" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "regoper" ) (
>            ScalarType "oid" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int8" ) (
>            ScalarType "regoper" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int2" ) (
>            ScalarType "regoper" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "regoper" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "regoper" ) (
>            ScalarType "int8" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "regoper" ) (
>            ScalarType "int4" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "regoper" ) (
>            ScalarType "regoperator" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "regoperator" ) (
>            ScalarType "regoper" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "oid" ) (
>            ScalarType "regoperator" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "regoperator" ) (
>            ScalarType "oid" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int8" ) (
>            ScalarType "regoperator" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int2" ) (
>            ScalarType "regoperator" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "regoperator" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "regoperator" ) (
>            ScalarType "int8" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "regoperator" ) (
>            ScalarType "int4" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "oid" ) (
>            ScalarType "regclass" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "regclass" ) (
>            ScalarType "oid" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int8" ) (
>            ScalarType "regclass" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int2" ) (
>            ScalarType "regclass" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "regclass" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "regclass" ) (
>            ScalarType "int8" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "regclass" ) (
>            ScalarType "int4" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "oid" ) (
>            ScalarType "regtype" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "regtype" ) (
>            ScalarType "oid" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int8" ) (
>            ScalarType "regtype" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int2" ) (
>            ScalarType "regtype" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "regtype" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "regtype" ) (
>            ScalarType "int8" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "regtype" ) (
>            ScalarType "int4" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "oid" ) (
>            ScalarType "regconfig" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "regconfig" ) (
>            ScalarType "oid" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int8" ) (
>            ScalarType "regconfig" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int2" ) (
>            ScalarType "regconfig" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "regconfig" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "regconfig" ) (
>            ScalarType "int8" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "regconfig" ) (
>            ScalarType "int4" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "oid" ) (
>            ScalarType "regdictionary" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "regdictionary" ) (
>            ScalarType "oid" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int8" ) (
>            ScalarType "regdictionary" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int2" ) (
>            ScalarType "regdictionary" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "regdictionary" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "regdictionary" ) (
>            ScalarType "int8" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "regdictionary" ) (
>            ScalarType "int4" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "text" ) (
>            ScalarType "regclass" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "varchar" ) (
>            ScalarType "regclass" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "text" ) (
>            ScalarType "bpchar" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "text" ) (
>            ScalarType "varchar" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "bpchar" ) (
>            ScalarType "text" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "bpchar" ) (
>            ScalarType "varchar" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "varchar" ) (
>            ScalarType "text" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "varchar" ) (
>            ScalarType "bpchar" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "char" ) (
>            ScalarType "text" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "char" ) (
>            ScalarType "bpchar" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "char" ) (
>            ScalarType "varchar" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "name" ) (
>            ScalarType "text" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "name" ) (
>            ScalarType "bpchar" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "name" ) (
>            ScalarType "varchar" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "text" ) (
>            ScalarType "char" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "bpchar" ) (
>            ScalarType "char" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "varchar" ) (
>            ScalarType "char" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "text" ) (
>            ScalarType "name" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "bpchar" ) (
>            ScalarType "name" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "varchar" ) (
>            ScalarType "name" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "char" ) (
>            ScalarType "int4" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "char" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "abstime" ) (
>            ScalarType "date" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "abstime" ) (
>            ScalarType "time" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "abstime" ) (
>            ScalarType "timestamp" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "abstime" ) (
>            ScalarType "timestamptz" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "reltime" ) (
>            ScalarType "interval" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "date" ) (
>            ScalarType "timestamp" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "date" ) (
>            ScalarType "timestamptz" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "time" ) (
>            ScalarType "interval" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "time" ) (
>            ScalarType "timetz" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "timestamp" ) (
>            ScalarType "abstime" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "timestamp" ) (
>            ScalarType "date" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "timestamp" ) (
>            ScalarType "time" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "timestamp" ) (
>            ScalarType "timestamptz" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "timestamptz" ) (
>            ScalarType "abstime" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "timestamptz" ) (
>            ScalarType "date" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "timestamptz" ) (
>            ScalarType "time" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "timestamptz" ) (
>            ScalarType "timestamp" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "timestamptz" ) (
>            ScalarType "timetz" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "interval" ) (
>            ScalarType "reltime" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "interval" ) (
>            ScalarType "time" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "timetz" ) (
>            ScalarType "time" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "abstime" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "abstime" ) (
>            ScalarType "int4" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "reltime" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "reltime" ) (
>            ScalarType "int4" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "lseg" ) (
>            ScalarType "point" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "path" ) (
>            ScalarType "point" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "path" ) (
>            ScalarType "polygon" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "box" ) (
>            ScalarType "point" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "box" ) (
>            ScalarType "lseg" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "box" ) (
>            ScalarType "polygon" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "box" ) (
>            ScalarType "circle" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "polygon" ) (
>            ScalarType "point" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "polygon" ) (
>            ScalarType "path" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "polygon" ) (
>            ScalarType "box" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "polygon" ) (
>            ScalarType "circle" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "circle" ) (
>            ScalarType "point" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "circle" ) (
>            ScalarType "box" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "circle" ) (
>            ScalarType "polygon" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "cidr" ) (
>            ScalarType "inet" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "inet" ) (
>            ScalarType "cidr" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "bit" ) (
>            ScalarType "varbit" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "varbit" ) (
>            ScalarType "bit" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int8" ) (
>            ScalarType "bit" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "int4" ) (
>            ScalarType "bit" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "bit" ) (
>            ScalarType "int8" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "bit" ) (
>            ScalarType "int4" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "cidr" ) (
>            ScalarType "text" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "inet" ) (
>            ScalarType "text" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "bool" ) (
>            ScalarType "text" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "xml" ) (
>            ScalarType "text" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "text" ) (
>            ScalarType "xml" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "cidr" ) (
>            ScalarType "varchar" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "inet" ) (
>            ScalarType "varchar" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "bool" ) (
>            ScalarType "varchar" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "xml" ) (
>            ScalarType "varchar" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "varchar" ) (
>            ScalarType "xml" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "cidr" ) (
>            ScalarType "bpchar" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "inet" ) (
>            ScalarType "bpchar" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "bool" ) (
>            ScalarType "bpchar" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "xml" ) (
>            ScalarType "bpchar" )
>            AssignmentCastContext
>        , EnvCreateCast (
>            ScalarType "bpchar" ) (
>            ScalarType "xml" )
>            ExplicitCastContext
>        , EnvCreateCast (
>            ScalarType "bpchar" ) (
>            ScalarType "bpchar" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "varchar" ) (
>            ScalarType "varchar" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "time" ) (
>            ScalarType "time" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "timestamp" ) (
>            ScalarType "timestamp" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "timestamptz" ) (
>            ScalarType "timestamptz" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "interval" ) (
>            ScalarType "interval" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "timetz" ) (
>            ScalarType "timetz" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "bit" ) (
>            ScalarType "bit" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "varbit" ) (
>            ScalarType "varbit" )
>            ImplicitCastContext
>        , EnvCreateCast (
>            ScalarType "numeric" ) (
>            ScalarType "numeric" )
>            ImplicitCastContext
>        , EnvCreateFunction
>            FunPrefix
>            "~"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "~"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "~"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "~"
>            [ ScalarType "bit"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "~"
>            [ ScalarType "inet"
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "||/"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "|/"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "|"
>            [ ScalarType "tinterval"
>            ] (
>            ScalarType "abstime" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "@@"
>            [ ScalarType "circle"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "@@"
>            [ ScalarType "lseg"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "@@"
>            [ ScalarType "path"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "@@"
>            [ ScalarType "polygon"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "@@"
>            [ ScalarType "box"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "@-@"
>            [ ScalarType "path"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "@-@"
>            [ ScalarType "lseg"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "@"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "@"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "@"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "@"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "@"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "@"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "?|"
>            [ ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "?|"
>            [ ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "?-"
>            [ ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "?-"
>            [ ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "-"
>            [ ScalarType "interval"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "-"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "-"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "-"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "-"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "-"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "-"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "+"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "+"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "+"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "+"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "+"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "+"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "#"
>            [ ScalarType "path"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "#"
>            [ ScalarType "polygon"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "!!"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunPrefix
>            "!!"
>            [ ScalarType "tsquery"
>            ] (
>            ScalarType "tsquery" )
>            False
>        , EnvCreateFunction
>            FunPostfix
>            "!"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~~*"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~~*"
>            [ ScalarType "bpchar"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~~*"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~~"
>            [ ScalarType "bpchar"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~~"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~~"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~~"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~>~"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~>~"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~>=~"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~>=~"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~="
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~="
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~="
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~="
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~="
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~<~"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~<~"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~<=~"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~<=~"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~*"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~*"
>            [ ScalarType "bpchar"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~*"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~"
>            [ ScalarType "bpchar"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~"
>            [ ArrayType ( ScalarType "aclitem" )
>            , ScalarType "aclitem"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~"
>            [ ScalarType "circle"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~"
>            [ ScalarType "polygon"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~"
>            [ ScalarType "path"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "~"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "||"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "||"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "||"
>            [ ScalarType "varbit"
>            , ScalarType "varbit"
>            ] (
>            ScalarType "varbit" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "||"
>            [ Pseudo AnyElement
>            , Pseudo AnyArray
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "||"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "tsquery" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "||"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "||"
>            [ Pseudo AnyNonArray
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "||"
>            [ ScalarType "tsvector"
>            , ScalarType "tsvector"
>            ] (
>            ScalarType "tsvector" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "||"
>            [ Pseudo AnyArray
>            , Pseudo AnyElement
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "||"
>            [ ScalarType "text"
>            , Pseudo AnyNonArray
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "|>>"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "|>>"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "|>>"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "|&>"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "|&>"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "|&>"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "|"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "|"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "|"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "|"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "|"
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "^"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "^"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "@@@"
>            [ ScalarType "tsquery"
>            , ScalarType "tsvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "@@@"
>            [ ScalarType "tsvector"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "@@"
>            [ ScalarType "text"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "@@"
>            [ ScalarType "tsquery"
>            , ScalarType "tsvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "@@"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "@@"
>            [ ScalarType "tsvector"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "@>"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "@>"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "@>"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "@>"
>            [ ScalarType "polygon"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "@>"
>            [ ScalarType "path"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "@>"
>            [ ArrayType ( ScalarType "aclitem" )
>            , ScalarType "aclitem"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "@>"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "@>"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "@>"
>            [ ScalarType "circle"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "?||"
>            [ ScalarType "line"
>            , ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "?||"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "?|"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "?-|"
>            [ ScalarType "line"
>            , ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "?-|"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "?-"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "?#"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "?#"
>            [ ScalarType "path"
>            , ScalarType "path"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "?#"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "?#"
>            [ ScalarType "lseg"
>            , ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "?#"
>            [ ScalarType "line"
>            , ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "?#"
>            [ ScalarType "lseg"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "?#"
>            [ ScalarType "line"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">^"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">^"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">>="
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">>"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">>"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">>"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">>"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">>"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">>"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">>"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">>"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">>"
>            [ ScalarType "bit"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "uuid"
>            , ScalarType "uuid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "macaddr"
>            , ScalarType "macaddr"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "char"
>            , ScalarType "char"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ Pseudo AnyEnum
>            , Pseudo AnyEnum
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "timestamp"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "date"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "timetz"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "varbit"
>            , ScalarType "varbit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "name"
>            , ScalarType "name"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "tsvector"
>            , ScalarType "tsvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "date"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "bool"
>            , ScalarType "bool"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ Pseudo Record
>            , Pseudo Record
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "timestamptz"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "timestamp"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "abstime"
>            , ScalarType "abstime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "path"
>            , ScalarType "path"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "date"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "tid"
>            , ScalarType "tid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "oidvector"
>            , ScalarType "oidvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "reltime"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">="
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "macaddr"
>            , ScalarType "macaddr"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "char"
>            , ScalarType "char"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ Pseudo AnyEnum
>            , Pseudo AnyEnum
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "reltime"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "timestamptz"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "date"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "timestamp"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "uuid"
>            , ScalarType "uuid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "timetz"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "name"
>            , ScalarType "name"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "oidvector"
>            , ScalarType "oidvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "path"
>            , ScalarType "path"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ Pseudo Record
>            , Pseudo Record
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "bool"
>            , ScalarType "bool"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "varbit"
>            , ScalarType "varbit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "tsvector"
>            , ScalarType "tsvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "date"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "date"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "tid"
>            , ScalarType "tid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            ">"
>            [ ScalarType "abstime"
>            , ScalarType "abstime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "reltime"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "date"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "date"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "oidvector"
>            , ScalarType "oidvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "timestamp"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "varbit"
>            , ScalarType "varbit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "timestamptz"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "timestamp"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "path"
>            , ScalarType "path"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "tid"
>            , ScalarType "tid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "aclitem"
>            , ScalarType "aclitem"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "uuid"
>            , ScalarType "uuid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "int2vector"
>            , ScalarType "int2vector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ Pseudo Record
>            , Pseudo Record
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "cid"
>            , ScalarType "cid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "xid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "macaddr"
>            , ScalarType "macaddr"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "line"
>            , ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ Pseudo AnyEnum
>            , Pseudo AnyEnum
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "xid"
>            , ScalarType "xid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "tsvector"
>            , ScalarType "tsvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "date"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "timetz"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "name"
>            , ScalarType "name"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "char"
>            , ScalarType "char"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "bool"
>            , ScalarType "bool"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "="
>            [ ScalarType "abstime"
>            , ScalarType "abstime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<^"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<^"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<@"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<@"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<@"
>            [ ScalarType "lseg"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<@"
>            [ ScalarType "lseg"
>            , ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<@"
>            [ ScalarType "point"
>            , ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<@"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<@"
>            [ ScalarType "point"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<@"
>            [ ScalarType "point"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<@"
>            [ ScalarType "point"
>            , ScalarType "path"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<@"
>            [ ScalarType "point"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<@"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<@"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<@"
>            [ ScalarType "point"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<?>"
>            [ ScalarType "abstime"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "timetz"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "reltime"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "tsvector"
>            , ScalarType "tsvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "date"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "oidvector"
>            , ScalarType "oidvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "char"
>            , ScalarType "char"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "date"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "abstime"
>            , ScalarType "abstime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "date"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "name"
>            , ScalarType "name"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "timestamp"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ Pseudo AnyEnum
>            , Pseudo AnyEnum
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "timestamptz"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "uuid"
>            , ScalarType "uuid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "varbit"
>            , ScalarType "varbit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "tid"
>            , ScalarType "tid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "bool"
>            , ScalarType "bool"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ Pseudo Record
>            , Pseudo Record
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<>"
>            [ ScalarType "macaddr"
>            , ScalarType "macaddr"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "oidvector"
>            , ScalarType "oidvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "reltime"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "tsvector"
>            , ScalarType "tsvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ Pseudo AnyEnum
>            , Pseudo AnyEnum
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "uuid"
>            , ScalarType "uuid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "tid"
>            , ScalarType "tid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "timetz"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "date"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "macaddr"
>            , ScalarType "macaddr"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "timestamp"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "timestamptz"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "bool"
>            , ScalarType "bool"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "timestamp"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ Pseudo Record
>            , Pseudo Record
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "date"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "path"
>            , ScalarType "path"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "date"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "varbit"
>            , ScalarType "varbit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "name"
>            , ScalarType "name"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "char"
>            , ScalarType "char"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "abstime"
>            , ScalarType "abstime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<="
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<<|"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<<|"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<<|"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<<="
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<<"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<<"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<<"
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<<"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<<"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<<"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<<"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<<"
>            [ ScalarType "bit"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<<"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<<"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<->"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<->"
>            [ ScalarType "circle"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<->"
>            [ ScalarType "point"
>            , ScalarType "line"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<->"
>            [ ScalarType "point"
>            , ScalarType "path"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<->"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<->"
>            [ ScalarType "point"
>            , ScalarType "circle"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<->"
>            [ ScalarType "lseg"
>            , ScalarType "box"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<->"
>            [ ScalarType "point"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<->"
>            [ ScalarType "lseg"
>            , ScalarType "line"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<->"
>            [ ScalarType "point"
>            , ScalarType "box"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<->"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<->"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<->"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<->"
>            [ ScalarType "line"
>            , ScalarType "line"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<->"
>            [ ScalarType "path"
>            , ScalarType "path"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<->"
>            [ ScalarType "line"
>            , ScalarType "box"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<#>"
>            [ ScalarType "abstime"
>            , ScalarType "abstime"
>            ] (
>            ScalarType "tinterval" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "oidvector"
>            , ScalarType "oidvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "timestamptz"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ Pseudo AnyEnum
>            , Pseudo AnyEnum
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "timestamp"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "tsvector"
>            , ScalarType "tsvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "varbit"
>            , ScalarType "varbit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "path"
>            , ScalarType "path"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "date"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "bool"
>            , ScalarType "bool"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "char"
>            , ScalarType "char"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ Pseudo Record
>            , Pseudo Record
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "name"
>            , ScalarType "name"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "date"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "macaddr"
>            , ScalarType "macaddr"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "abstime"
>            , ScalarType "abstime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "tid"
>            , ScalarType "tid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "uuid"
>            , ScalarType "uuid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "timetz"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "date"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "reltime"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "<"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "money"
>            , ScalarType "float4"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "circle"
>            , ScalarType "point"
>            ] (
>            ScalarType "circle" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "money"
>            , ScalarType "int4"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "path"
>            , ScalarType "point"
>            ] (
>            ScalarType "path" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "interval"
>            , ScalarType "float8"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "money"
>            , ScalarType "int2"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "money"
>            , ScalarType "float8"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "/"
>            [ ScalarType "box"
>            , ScalarType "point"
>            ] (
>            ScalarType "box" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "timestamptz"
>            , ScalarType "interval"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "circle"
>            , ScalarType "point"
>            ] (
>            ScalarType "circle" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "date"
>            , ScalarType "int4"
>            ] (
>            ScalarType "date" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "date"
>            , ScalarType "date"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "date"
>            , ScalarType "interval"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ArrayType ( ScalarType "aclitem" )
>            , ScalarType "aclitem"
>            ] (
>            ArrayType ( ScalarType "aclitem" ) )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "inet"
>            , ScalarType "int8"
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "box"
>            , ScalarType "point"
>            ] (
>            ScalarType "box" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "path"
>            , ScalarType "point"
>            ] (
>            ScalarType "path" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "time"
>            , ScalarType "interval"
>            ] (
>            ScalarType "time" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "timetz"
>            , ScalarType "interval"
>            ] (
>            ScalarType "timetz" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "abstime"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "abstime" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "timestamp"
>            , ScalarType "interval"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "-"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "date"
>            , ScalarType "time"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "timetz"
>            , ScalarType "interval"
>            ] (
>            ScalarType "timetz" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "time"
>            , ScalarType "interval"
>            ] (
>            ScalarType "time" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "timestamp"
>            , ScalarType "interval"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "time"
>            , ScalarType "date"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "date"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "path"
>            , ScalarType "path"
>            ] (
>            ScalarType "path" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "path"
>            , ScalarType "point"
>            ] (
>            ScalarType "path" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "box"
>            , ScalarType "point"
>            ] (
>            ScalarType "box" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "int8"
>            , ScalarType "inet"
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ArrayType ( ScalarType "aclitem" )
>            , ScalarType "aclitem"
>            ] (
>            ArrayType ( ScalarType "aclitem" ) )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "inet"
>            , ScalarType "int8"
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "interval"
>            , ScalarType "date"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "date"
>            , ScalarType "interval"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "timetz"
>            , ScalarType "date"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "interval"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "timetz" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "interval"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "date"
>            , ScalarType "int4"
>            ] (
>            ScalarType "date" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "interval"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "int4"
>            , ScalarType "date"
>            ] (
>            ScalarType "date" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "circle"
>            , ScalarType "point"
>            ] (
>            ScalarType "circle" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "timestamptz"
>            , ScalarType "interval"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "abstime"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "abstime" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "+"
>            [ ScalarType "interval"
>            , ScalarType "time"
>            ] (
>            ScalarType "time" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "path"
>            , ScalarType "point"
>            ] (
>            ScalarType "path" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "box"
>            , ScalarType "point"
>            ] (
>            ScalarType "box" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "money"
>            , ScalarType "float4"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "float4"
>            , ScalarType "money"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "money"
>            , ScalarType "float8"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "money"
>            , ScalarType "int4"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "money"
>            , ScalarType "int2"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "float8"
>            , ScalarType "money"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "int4"
>            , ScalarType "money"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "int2"
>            , ScalarType "money"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "circle"
>            , ScalarType "point"
>            ] (
>            ScalarType "circle" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "float8"
>            , ScalarType "interval"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "interval"
>            , ScalarType "float8"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "*"
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&>"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&>"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&>"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&<|"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&<|"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&<|"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&<"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&<"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&<"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&&"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&&"
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&&"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&&"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&&"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&&"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "tsquery" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&"
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "&"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "%"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "%"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "%"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "%"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "#>="
>            [ ScalarType "tinterval"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "#>"
>            [ ScalarType "tinterval"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "#="
>            [ ScalarType "tinterval"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "#<>"
>            [ ScalarType "tinterval"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "#<="
>            [ ScalarType "tinterval"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "#<"
>            [ ScalarType "tinterval"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "##"
>            [ ScalarType "line"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "##"
>            [ ScalarType "lseg"
>            , ScalarType "line"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "##"
>            [ ScalarType "point"
>            , ScalarType "box"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "##"
>            [ ScalarType "lseg"
>            , ScalarType "box"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "##"
>            [ ScalarType "line"
>            , ScalarType "box"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "##"
>            [ ScalarType "point"
>            , ScalarType "line"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "##"
>            [ ScalarType "point"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "##"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "#"
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "#"
>            [ ScalarType "line"
>            , ScalarType "line"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "#"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "box" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "#"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "#"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "#"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "#"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "!~~*"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "!~~*"
>            [ ScalarType "bpchar"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "!~~*"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "!~~"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "!~~"
>            [ ScalarType "bpchar"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "!~~"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "!~~"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "!~*"
>            [ ScalarType "bpchar"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "!~*"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "!~*"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "!~"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "!~"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunBinary
>            "!~"
>            [ ScalarType "bpchar"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "RI_FKey_cascade_del"
>            [] (
>            Pseudo Trigger )
>            False
>        , EnvCreateFunction
>            FunName
>            "RI_FKey_cascade_upd"
>            [] (
>            Pseudo Trigger )
>            False
>        , EnvCreateFunction
>            FunName
>            "RI_FKey_check_ins"
>            [] (
>            Pseudo Trigger )
>            False
>        , EnvCreateFunction
>            FunName
>            "RI_FKey_check_upd"
>            [] (
>            Pseudo Trigger )
>            False
>        , EnvCreateFunction
>            FunName
>            "RI_FKey_noaction_del"
>            [] (
>            Pseudo Trigger )
>            False
>        , EnvCreateFunction
>            FunName
>            "RI_FKey_noaction_upd"
>            [] (
>            Pseudo Trigger )
>            False
>        , EnvCreateFunction
>            FunName
>            "RI_FKey_restrict_del"
>            [] (
>            Pseudo Trigger )
>            False
>        , EnvCreateFunction
>            FunName
>            "RI_FKey_restrict_upd"
>            [] (
>            Pseudo Trigger )
>            False
>        , EnvCreateFunction
>            FunName
>            "RI_FKey_setdefault_del"
>            [] (
>            Pseudo Trigger )
>            False
>        , EnvCreateFunction
>            FunName
>            "RI_FKey_setdefault_upd"
>            [] (
>            Pseudo Trigger )
>            False
>        , EnvCreateFunction
>            FunName
>            "RI_FKey_setnull_del"
>            [] (
>            Pseudo Trigger )
>            False
>        , EnvCreateFunction
>            FunName
>            "RI_FKey_setnull_upd"
>            [] (
>            Pseudo Trigger )
>            False
>        , EnvCreateFunction
>            FunName
>            "abbrev"
>            [ ScalarType "cidr"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "abbrev"
>            [ ScalarType "inet"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "abs"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "abs"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "abs"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "abs"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "abs"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "abs"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "abstime"
>            [ ScalarType "timestamp"
>            ] (
>            ScalarType "abstime" )
>            False
>        , EnvCreateFunction
>            FunName
>            "abstime"
>            [ ScalarType "timestamptz"
>            ] (
>            ScalarType "abstime" )
>            False
>        , EnvCreateFunction
>            FunName
>            "abstimeeq"
>            [ ScalarType "abstime"
>            , ScalarType "abstime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "abstimege"
>            [ ScalarType "abstime"
>            , ScalarType "abstime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "abstimegt"
>            [ ScalarType "abstime"
>            , ScalarType "abstime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "abstimein"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "abstime" )
>            False
>        , EnvCreateFunction
>            FunName
>            "abstimele"
>            [ ScalarType "abstime"
>            , ScalarType "abstime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "abstimelt"
>            [ ScalarType "abstime"
>            , ScalarType "abstime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "abstimene"
>            [ ScalarType "abstime"
>            , ScalarType "abstime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "abstimeout"
>            [ ScalarType "abstime"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "abstimerecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "abstime" )
>            False
>        , EnvCreateFunction
>            FunName
>            "abstimesend"
>            [ ScalarType "abstime"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "aclcontains"
>            [ ArrayType ( ScalarType "aclitem" )
>            , ScalarType "aclitem"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "aclinsert"
>            [ ArrayType ( ScalarType "aclitem" )
>            , ScalarType "aclitem"
>            ] (
>            ArrayType ( ScalarType "aclitem" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "aclitemeq"
>            [ ScalarType "aclitem"
>            , ScalarType "aclitem"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "aclitemin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "aclitem" )
>            False
>        , EnvCreateFunction
>            FunName
>            "aclitemout"
>            [ ScalarType "aclitem"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "aclremove"
>            [ ArrayType ( ScalarType "aclitem" )
>            , ScalarType "aclitem"
>            ] (
>            ArrayType ( ScalarType "aclitem" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "acos"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "age"
>            [ ScalarType "xid"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "age"
>            [ ScalarType "timestamp"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "age"
>            [ ScalarType "timestamptz"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "age"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "age"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "any_in"
>            [ Pseudo Cstring
>            ] (
>            Pseudo Any )
>            False
>        , EnvCreateFunction
>            FunName
>            "any_out"
>            [ Pseudo Any
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "anyarray_in"
>            [ Pseudo Cstring
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunName
>            "anyarray_out"
>            [ Pseudo AnyArray
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "anyarray_recv"
>            [ Pseudo Internal
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunName
>            "anyarray_send"
>            [ Pseudo AnyArray
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "anyelement_in"
>            [ Pseudo Cstring
>            ] (
>            Pseudo AnyElement )
>            False
>        , EnvCreateFunction
>            FunName
>            "anyelement_out"
>            [ Pseudo AnyElement
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "anyenum_in"
>            [ Pseudo Cstring
>            ] (
>            Pseudo AnyEnum )
>            False
>        , EnvCreateFunction
>            FunName
>            "anyenum_out"
>            [ Pseudo AnyEnum
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "anynonarray_in"
>            [ Pseudo Cstring
>            ] (
>            Pseudo AnyNonArray )
>            False
>        , EnvCreateFunction
>            FunName
>            "anynonarray_out"
>            [ Pseudo AnyNonArray
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "anytextcat"
>            [ Pseudo AnyNonArray
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "area"
>            [ ScalarType "path"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "area"
>            [ ScalarType "box"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "area"
>            [ ScalarType "circle"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "areajoinsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo Internal
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "areasel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_agg_finalfn"
>            [ Pseudo Internal
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_agg_transfn"
>            [ Pseudo Internal
>            , Pseudo AnyElement
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_append"
>            [ Pseudo AnyArray
>            , Pseudo AnyElement
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_cat"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_dims"
>            [ Pseudo AnyArray
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_eq"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_fill"
>            [ Pseudo AnyElement
>            , ArrayType ( ScalarType "int4" )
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_fill"
>            [ Pseudo AnyElement
>            , ArrayType ( ScalarType "int4" )
>            , ArrayType ( ScalarType "int4" )
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_ge"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_gt"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_in"
>            [ Pseudo Cstring
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_larger"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_le"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_length"
>            [ Pseudo AnyArray
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_lower"
>            [ Pseudo AnyArray
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_lt"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_ndims"
>            [ Pseudo AnyArray
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_ne"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_out"
>            [ Pseudo AnyArray
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_prepend"
>            [ Pseudo AnyElement
>            , Pseudo AnyArray
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_recv"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_send"
>            [ Pseudo AnyArray
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_smaller"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_to_string"
>            [ Pseudo AnyArray
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "array_upper"
>            [ Pseudo AnyArray
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "arraycontained"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "arraycontains"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "arrayoverlap"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ascii"
>            [ ScalarType "text"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ascii_to_mic"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "ascii_to_utf8"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "asin"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "atan"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "atan2"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "big5_to_euc_tw"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "big5_to_mic"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "big5_to_utf8"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "bit"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bit"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bit"
>            [ ScalarType "bit"
>            , ScalarType "int4"
>            , ScalarType "bool"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bit_in"
>            [ Pseudo Cstring
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bit_length"
>            [ ScalarType "bytea"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bit_length"
>            [ ScalarType "text"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bit_length"
>            [ ScalarType "bit"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bit_out"
>            [ ScalarType "bit"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "bit_recv"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bit_send"
>            [ ScalarType "bit"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bitand"
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bitcat"
>            [ ScalarType "varbit"
>            , ScalarType "varbit"
>            ] (
>            ScalarType "varbit" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bitcmp"
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "biteq"
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bitge"
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bitgt"
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bitle"
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bitlt"
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bitne"
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bitnot"
>            [ ScalarType "bit"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bitor"
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bitshiftleft"
>            [ ScalarType "bit"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bitshiftright"
>            [ ScalarType "bit"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bittypmodin"
>            [ ArrayType ( Pseudo Cstring )
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bittypmodout"
>            [ ScalarType "int4"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "bitxor"
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bool"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "booland_statefunc"
>            [ ScalarType "bool"
>            , ScalarType "bool"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "booleq"
>            [ ScalarType "bool"
>            , ScalarType "bool"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "boolge"
>            [ ScalarType "bool"
>            , ScalarType "bool"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "boolgt"
>            [ ScalarType "bool"
>            , ScalarType "bool"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "boolin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "boolle"
>            [ ScalarType "bool"
>            , ScalarType "bool"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "boollt"
>            [ ScalarType "bool"
>            , ScalarType "bool"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "boolne"
>            [ ScalarType "bool"
>            , ScalarType "bool"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "boolor_statefunc"
>            [ ScalarType "bool"
>            , ScalarType "bool"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "boolout"
>            [ ScalarType "bool"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "boolrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "boolsend"
>            [ ScalarType "bool"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box"
>            [ ScalarType "polygon"
>            ] (
>            ScalarType "box" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box"
>            [ ScalarType "circle"
>            ] (
>            ScalarType "box" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "box" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_above"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_above_eq"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_add"
>            [ ScalarType "box"
>            , ScalarType "point"
>            ] (
>            ScalarType "box" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_below"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_below_eq"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_center"
>            [ ScalarType "box"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_contain"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_contained"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_distance"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_div"
>            [ ScalarType "box"
>            , ScalarType "point"
>            ] (
>            ScalarType "box" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_eq"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_ge"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_gt"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "box" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_intersect"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "box" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_le"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_left"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_lt"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_mul"
>            [ ScalarType "box"
>            , ScalarType "point"
>            ] (
>            ScalarType "box" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_out"
>            [ ScalarType "box"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_overabove"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_overbelow"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_overlap"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_overleft"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_overright"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "box" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_right"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_same"
>            [ ScalarType "box"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_send"
>            [ ScalarType "box"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "box_sub"
>            [ ScalarType "box"
>            , ScalarType "point"
>            ] (
>            ScalarType "box" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpchar"
>            [ ScalarType "char"
>            ] (
>            ScalarType "bpchar" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpchar"
>            [ ScalarType "name"
>            ] (
>            ScalarType "bpchar" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpchar"
>            [ ScalarType "bpchar"
>            , ScalarType "int4"
>            , ScalarType "bool"
>            ] (
>            ScalarType "bpchar" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpchar_larger"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bpchar" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpchar_pattern_ge"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpchar_pattern_gt"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpchar_pattern_le"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpchar_pattern_lt"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpchar_smaller"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bpchar" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpcharcmp"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpchareq"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpcharge"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpchargt"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpchariclike"
>            [ ScalarType "bpchar"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpcharicnlike"
>            [ ScalarType "bpchar"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpcharicregexeq"
>            [ ScalarType "bpchar"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpcharicregexne"
>            [ ScalarType "bpchar"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpcharin"
>            [ Pseudo Cstring
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bpchar" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpcharle"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpcharlike"
>            [ ScalarType "bpchar"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpcharlt"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpcharne"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpcharnlike"
>            [ ScalarType "bpchar"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpcharout"
>            [ ScalarType "bpchar"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpcharrecv"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bpchar" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpcharregexeq"
>            [ ScalarType "bpchar"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpcharregexne"
>            [ ScalarType "bpchar"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpcharsend"
>            [ ScalarType "bpchar"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpchartypmodin"
>            [ ArrayType ( Pseudo Cstring )
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bpchartypmodout"
>            [ ScalarType "int4"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "broadcast"
>            [ ScalarType "inet"
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btabstimecmp"
>            [ ScalarType "abstime"
>            , ScalarType "abstime"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btarraycmp"
>            [ Pseudo AnyArray
>            , Pseudo AnyArray
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btbeginscan"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "btboolcmp"
>            [ ScalarType "bool"
>            , ScalarType "bool"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btbpchar_pattern_cmp"
>            [ ScalarType "bpchar"
>            , ScalarType "bpchar"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btbuild"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "btbulkdelete"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "btcharcmp"
>            [ ScalarType "char"
>            , ScalarType "char"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btcostestimate"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "btendscan"
>            [ Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "btfloat48cmp"
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btfloat4cmp"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btfloat84cmp"
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btfloat8cmp"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btgetbitmap"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btgettuple"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btinsert"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btint24cmp"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btint28cmp"
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btint2cmp"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btint42cmp"
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btint48cmp"
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btint4cmp"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btint82cmp"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btint84cmp"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btint8cmp"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btmarkpos"
>            [ Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "btnamecmp"
>            [ ScalarType "name"
>            , ScalarType "name"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btoidcmp"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btoidvectorcmp"
>            [ ScalarType "oidvector"
>            , ScalarType "oidvector"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btoptions"
>            [ ArrayType ( ScalarType "text" )
>            , ScalarType "bool"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btrecordcmp"
>            [ Pseudo Record
>            , Pseudo Record
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btreltimecmp"
>            [ ScalarType "reltime"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btrescan"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "btrestrpos"
>            [ Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "btrim"
>            [ ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btrim"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btrim"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bttext_pattern_cmp"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bttextcmp"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bttidcmp"
>            [ ScalarType "tid"
>            , ScalarType "tid"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bttintervalcmp"
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "btvacuumcleanup"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "byteacat"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "byteacmp"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "byteaeq"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "byteage"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "byteagt"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "byteain"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "byteale"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bytealike"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "bytealt"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "byteane"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "byteanlike"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "byteaout"
>            [ ScalarType "bytea"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "bytearecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "byteasend"
>            [ ScalarType "bytea"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_cmp"
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_div_flt4"
>            [ ScalarType "money"
>            , ScalarType "float4"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_div_flt8"
>            [ ScalarType "money"
>            , ScalarType "float8"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_div_int2"
>            [ ScalarType "money"
>            , ScalarType "int2"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_div_int4"
>            [ ScalarType "money"
>            , ScalarType "int4"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_eq"
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_ge"
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_gt"
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_le"
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_lt"
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_mi"
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_mul_flt4"
>            [ ScalarType "money"
>            , ScalarType "float4"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_mul_flt8"
>            [ ScalarType "money"
>            , ScalarType "float8"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_mul_int2"
>            [ ScalarType "money"
>            , ScalarType "int2"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_mul_int4"
>            [ ScalarType "money"
>            , ScalarType "int4"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_ne"
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_out"
>            [ ScalarType "money"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_pl"
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_send"
>            [ ScalarType "money"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cash_words"
>            [ ScalarType "money"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cashlarger"
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cashsmaller"
>            [ ScalarType "money"
>            , ScalarType "money"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cbrt"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ceil"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ceil"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ceiling"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ceiling"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "center"
>            [ ScalarType "box"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "center"
>            [ ScalarType "circle"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "char"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "char" )
>            False
>        , EnvCreateFunction
>            FunName
>            "char"
>            [ ScalarType "text"
>            ] (
>            ScalarType "char" )
>            False
>        , EnvCreateFunction
>            FunName
>            "char_length"
>            [ ScalarType "text"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "char_length"
>            [ ScalarType "bpchar"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "character_length"
>            [ ScalarType "text"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "character_length"
>            [ ScalarType "bpchar"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "chareq"
>            [ ScalarType "char"
>            , ScalarType "char"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "charge"
>            [ ScalarType "char"
>            , ScalarType "char"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "chargt"
>            [ ScalarType "char"
>            , ScalarType "char"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "charin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "char" )
>            False
>        , EnvCreateFunction
>            FunName
>            "charle"
>            [ ScalarType "char"
>            , ScalarType "char"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "charlt"
>            [ ScalarType "char"
>            , ScalarType "char"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "charne"
>            [ ScalarType "char"
>            , ScalarType "char"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "charout"
>            [ ScalarType "char"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "charrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "char" )
>            False
>        , EnvCreateFunction
>            FunName
>            "charsend"
>            [ ScalarType "char"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "chr"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cideq"
>            [ ScalarType "cid"
>            , ScalarType "cid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cidin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "cid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cidout"
>            [ ScalarType "cid"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "cidr"
>            [ ScalarType "inet"
>            ] (
>            ScalarType "cidr" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cidr_in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "cidr" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cidr_out"
>            [ ScalarType "cidr"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "cidr_recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "cidr" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cidr_send"
>            [ ScalarType "cidr"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cidrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "cid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cidsend"
>            [ ScalarType "cid"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle"
>            [ ScalarType "box"
>            ] (
>            ScalarType "circle" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle"
>            [ ScalarType "polygon"
>            ] (
>            ScalarType "circle" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle"
>            [ ScalarType "point"
>            , ScalarType "float8"
>            ] (
>            ScalarType "circle" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_above"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_add_pt"
>            [ ScalarType "circle"
>            , ScalarType "point"
>            ] (
>            ScalarType "circle" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_below"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_center"
>            [ ScalarType "circle"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_contain"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_contain_pt"
>            [ ScalarType "circle"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_contained"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_distance"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_div_pt"
>            [ ScalarType "circle"
>            , ScalarType "point"
>            ] (
>            ScalarType "circle" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_eq"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_ge"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_gt"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "circle" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_le"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_left"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_lt"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_mul_pt"
>            [ ScalarType "circle"
>            , ScalarType "point"
>            ] (
>            ScalarType "circle" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_ne"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_out"
>            [ ScalarType "circle"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_overabove"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_overbelow"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_overlap"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_overleft"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_overright"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "circle" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_right"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_same"
>            [ ScalarType "circle"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_send"
>            [ ScalarType "circle"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "circle_sub_pt"
>            [ ScalarType "circle"
>            , ScalarType "point"
>            ] (
>            ScalarType "circle" )
>            False
>        , EnvCreateFunction
>            FunName
>            "clock_timestamp"
>            [] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "close_lb"
>            [ ScalarType "line"
>            , ScalarType "box"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "close_ls"
>            [ ScalarType "line"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "close_lseg"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "close_pb"
>            [ ScalarType "point"
>            , ScalarType "box"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "close_pl"
>            [ ScalarType "point"
>            , ScalarType "line"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "close_ps"
>            [ ScalarType "point"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "close_sb"
>            [ ScalarType "lseg"
>            , ScalarType "box"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "close_sl"
>            [ ScalarType "lseg"
>            , ScalarType "line"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "col_description"
>            [ ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "contjoinsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo Internal
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "contsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "convert"
>            [ ScalarType "bytea"
>            , ScalarType "name"
>            , ScalarType "name"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "convert_from"
>            [ ScalarType "bytea"
>            , ScalarType "name"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "convert_to"
>            [ ScalarType "text"
>            , ScalarType "name"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cos"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cot"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cstring_in"
>            [ Pseudo Cstring
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "cstring_out"
>            [ Pseudo Cstring
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "cstring_recv"
>            [ Pseudo Internal
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "cstring_send"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "current_database"
>            [] (
>            ScalarType "name" )
>            False
>        , EnvCreateFunction
>            FunName
>            "current_query"
>            [] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "current_schema"
>            [] (
>            ScalarType "name" )
>            False
>        , EnvCreateFunction
>            FunName
>            "current_schemas"
>            [ ScalarType "bool"
>            ] (
>            ArrayType ( ScalarType "name" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "current_setting"
>            [ ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "current_user"
>            [] (
>            ScalarType "name" )
>            False
>        , EnvCreateFunction
>            FunName
>            "currtid"
>            [ ScalarType "oid"
>            , ScalarType "tid"
>            ] (
>            ScalarType "tid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "currtid2"
>            [ ScalarType "text"
>            , ScalarType "tid"
>            ] (
>            ScalarType "tid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "currval"
>            [ ScalarType "regclass"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cursor_to_xml"
>            [ ScalarType "refcursor"
>            , ScalarType "int4"
>            , ScalarType "bool"
>            , ScalarType "bool"
>            , ScalarType "text"
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "cursor_to_xmlschema"
>            [ ScalarType "refcursor"
>            , ScalarType "bool"
>            , ScalarType "bool"
>            , ScalarType "text"
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "database_to_xml"
>            [ ScalarType "bool"
>            , ScalarType "bool"
>            , ScalarType "text"
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "database_to_xml_and_xmlschema"
>            [ ScalarType "bool"
>            , ScalarType "bool"
>            , ScalarType "text"
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "database_to_xmlschema"
>            [ ScalarType "bool"
>            , ScalarType "bool"
>            , ScalarType "text"
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date"
>            [ ScalarType "abstime"
>            ] (
>            ScalarType "date" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date"
>            [ ScalarType "timestamp"
>            ] (
>            ScalarType "date" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date"
>            [ ScalarType "timestamptz"
>            ] (
>            ScalarType "date" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_cmp"
>            [ ScalarType "date"
>            , ScalarType "date"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_cmp_timestamp"
>            [ ScalarType "date"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_cmp_timestamptz"
>            [ ScalarType "date"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_eq"
>            [ ScalarType "date"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_eq_timestamp"
>            [ ScalarType "date"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_eq_timestamptz"
>            [ ScalarType "date"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_ge"
>            [ ScalarType "date"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_ge_timestamp"
>            [ ScalarType "date"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_ge_timestamptz"
>            [ ScalarType "date"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_gt"
>            [ ScalarType "date"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_gt_timestamp"
>            [ ScalarType "date"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_gt_timestamptz"
>            [ ScalarType "date"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "date" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_larger"
>            [ ScalarType "date"
>            , ScalarType "date"
>            ] (
>            ScalarType "date" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_le"
>            [ ScalarType "date"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_le_timestamp"
>            [ ScalarType "date"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_le_timestamptz"
>            [ ScalarType "date"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_lt"
>            [ ScalarType "date"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_lt_timestamp"
>            [ ScalarType "date"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_lt_timestamptz"
>            [ ScalarType "date"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_mi"
>            [ ScalarType "date"
>            , ScalarType "date"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_mi_interval"
>            [ ScalarType "date"
>            , ScalarType "interval"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_mii"
>            [ ScalarType "date"
>            , ScalarType "int4"
>            ] (
>            ScalarType "date" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_ne"
>            [ ScalarType "date"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_ne_timestamp"
>            [ ScalarType "date"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_ne_timestamptz"
>            [ ScalarType "date"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_out"
>            [ ScalarType "date"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_part"
>            [ ScalarType "text"
>            , ScalarType "abstime"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_part"
>            [ ScalarType "text"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_part"
>            [ ScalarType "text"
>            , ScalarType "date"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_part"
>            [ ScalarType "text"
>            , ScalarType "time"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_part"
>            [ ScalarType "text"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_part"
>            [ ScalarType "text"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_part"
>            [ ScalarType "text"
>            , ScalarType "interval"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_part"
>            [ ScalarType "text"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_pl_interval"
>            [ ScalarType "date"
>            , ScalarType "interval"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_pli"
>            [ ScalarType "date"
>            , ScalarType "int4"
>            ] (
>            ScalarType "date" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "date" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_send"
>            [ ScalarType "date"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_smaller"
>            [ ScalarType "date"
>            , ScalarType "date"
>            ] (
>            ScalarType "date" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_trunc"
>            [ ScalarType "text"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_trunc"
>            [ ScalarType "text"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "date_trunc"
>            [ ScalarType "text"
>            , ScalarType "interval"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "datetime_pl"
>            [ ScalarType "date"
>            , ScalarType "time"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "datetimetz_pl"
>            [ ScalarType "date"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "dcbrt"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "decode"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "degrees"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "dexp"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "diagonal"
>            [ ScalarType "box"
>            ] (
>            ScalarType "lseg" )
>            False
>        , EnvCreateFunction
>            FunName
>            "diameter"
>            [ ScalarType "circle"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "dispell_init"
>            [ Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "dispell_lexize"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "dist_cpoly"
>            [ ScalarType "circle"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "dist_lb"
>            [ ScalarType "line"
>            , ScalarType "box"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "dist_pb"
>            [ ScalarType "point"
>            , ScalarType "box"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "dist_pc"
>            [ ScalarType "point"
>            , ScalarType "circle"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "dist_pl"
>            [ ScalarType "point"
>            , ScalarType "line"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "dist_ppath"
>            [ ScalarType "point"
>            , ScalarType "path"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "dist_ps"
>            [ ScalarType "point"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "dist_sb"
>            [ ScalarType "lseg"
>            , ScalarType "box"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "dist_sl"
>            [ ScalarType "lseg"
>            , ScalarType "line"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "div"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "dlog1"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "dlog10"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "domain_in"
>            [ Pseudo Cstring
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            Pseudo Any )
>            False
>        , EnvCreateFunction
>            FunName
>            "domain_recv"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            Pseudo Any )
>            False
>        , EnvCreateFunction
>            FunName
>            "dpow"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "dround"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "dsimple_init"
>            [ Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "dsimple_lexize"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "dsnowball_init"
>            [ Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "dsnowball_lexize"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "dsqrt"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "dsynonym_init"
>            [ Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "dsynonym_lexize"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "dtrunc"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "encode"
>            [ ScalarType "bytea"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "enum_cmp"
>            [ Pseudo AnyEnum
>            , Pseudo AnyEnum
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "enum_eq"
>            [ Pseudo AnyEnum
>            , Pseudo AnyEnum
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "enum_first"
>            [ Pseudo AnyEnum
>            ] (
>            Pseudo AnyEnum )
>            False
>        , EnvCreateFunction
>            FunName
>            "enum_ge"
>            [ Pseudo AnyEnum
>            , Pseudo AnyEnum
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "enum_gt"
>            [ Pseudo AnyEnum
>            , Pseudo AnyEnum
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "enum_in"
>            [ Pseudo Cstring
>            , ScalarType "oid"
>            ] (
>            Pseudo AnyEnum )
>            False
>        , EnvCreateFunction
>            FunName
>            "enum_larger"
>            [ Pseudo AnyEnum
>            , Pseudo AnyEnum
>            ] (
>            Pseudo AnyEnum )
>            False
>        , EnvCreateFunction
>            FunName
>            "enum_last"
>            [ Pseudo AnyEnum
>            ] (
>            Pseudo AnyEnum )
>            False
>        , EnvCreateFunction
>            FunName
>            "enum_le"
>            [ Pseudo AnyEnum
>            , Pseudo AnyEnum
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "enum_lt"
>            [ Pseudo AnyEnum
>            , Pseudo AnyEnum
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "enum_ne"
>            [ Pseudo AnyEnum
>            , Pseudo AnyEnum
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "enum_out"
>            [ Pseudo AnyEnum
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "enum_range"
>            [ Pseudo AnyEnum
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunName
>            "enum_range"
>            [ Pseudo AnyEnum
>            , Pseudo AnyEnum
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunName
>            "enum_recv"
>            [ Pseudo Cstring
>            , ScalarType "oid"
>            ] (
>            Pseudo AnyEnum )
>            False
>        , EnvCreateFunction
>            FunName
>            "enum_send"
>            [ Pseudo AnyEnum
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "enum_smaller"
>            [ Pseudo AnyEnum
>            , Pseudo AnyEnum
>            ] (
>            Pseudo AnyEnum )
>            False
>        , EnvCreateFunction
>            FunName
>            "eqjoinsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo Internal
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "eqsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "euc_cn_to_mic"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "euc_cn_to_utf8"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "euc_jis_2004_to_shift_jis_2004"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "euc_jis_2004_to_utf8"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "euc_jp_to_mic"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "euc_jp_to_sjis"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "euc_jp_to_utf8"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "euc_kr_to_mic"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "euc_kr_to_utf8"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "euc_tw_to_big5"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "euc_tw_to_mic"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "euc_tw_to_utf8"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "exp"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "exp"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "factorial"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "family"
>            [ ScalarType "inet"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "flatfile_update_trigger"
>            [] (
>            Pseudo Trigger )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float48div"
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float48eq"
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float48ge"
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float48gt"
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float48le"
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float48lt"
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float48mi"
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float48mul"
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float48ne"
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float48pl"
>            [ ScalarType "float4"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4_accum"
>            [ ArrayType ( ScalarType "float8" )
>            , ScalarType "float4"
>            ] (
>            ArrayType ( ScalarType "float8" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4abs"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4div"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4eq"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4ge"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4gt"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4larger"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4le"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4lt"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4mi"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4mul"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4ne"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4out"
>            [ ScalarType "float4"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4pl"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4send"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4smaller"
>            [ ScalarType "float4"
>            , ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4um"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float4up"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float84div"
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float84eq"
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float84ge"
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float84gt"
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float84le"
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float84lt"
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float84mi"
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float84mul"
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float84ne"
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float84pl"
>            [ ScalarType "float8"
>            , ScalarType "float4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8_accum"
>            [ ArrayType ( ScalarType "float8" )
>            , ScalarType "float8"
>            ] (
>            ArrayType ( ScalarType "float8" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8_avg"
>            [ ArrayType ( ScalarType "float8" )
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8_corr"
>            [ ArrayType ( ScalarType "float8" )
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8_covar_pop"
>            [ ArrayType ( ScalarType "float8" )
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8_covar_samp"
>            [ ArrayType ( ScalarType "float8" )
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8_regr_accum"
>            [ ArrayType ( ScalarType "float8" )
>            , ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ArrayType ( ScalarType "float8" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8_regr_avgx"
>            [ ArrayType ( ScalarType "float8" )
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8_regr_avgy"
>            [ ArrayType ( ScalarType "float8" )
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8_regr_intercept"
>            [ ArrayType ( ScalarType "float8" )
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8_regr_r2"
>            [ ArrayType ( ScalarType "float8" )
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8_regr_slope"
>            [ ArrayType ( ScalarType "float8" )
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8_regr_sxx"
>            [ ArrayType ( ScalarType "float8" )
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8_regr_sxy"
>            [ ArrayType ( ScalarType "float8" )
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8_regr_syy"
>            [ ArrayType ( ScalarType "float8" )
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8_stddev_pop"
>            [ ArrayType ( ScalarType "float8" )
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8_stddev_samp"
>            [ ArrayType ( ScalarType "float8" )
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8_var_pop"
>            [ ArrayType ( ScalarType "float8" )
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8_var_samp"
>            [ ArrayType ( ScalarType "float8" )
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8abs"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8div"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8eq"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8ge"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8gt"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8larger"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8le"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8lt"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8mi"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8mul"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8ne"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8out"
>            [ ScalarType "float8"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8pl"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8send"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8smaller"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8um"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "float8up"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "floor"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "floor"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "flt4_mul_cash"
>            [ ScalarType "float4"
>            , ScalarType "money"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunName
>            "flt8_mul_cash"
>            [ ScalarType "float8"
>            , ScalarType "money"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunName
>            "fmgr_c_validator"
>            [ ScalarType "oid"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "fmgr_internal_validator"
>            [ ScalarType "oid"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "fmgr_sql_validator"
>            [ ScalarType "oid"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "format_type"
>            [ ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "gb18030_to_utf8"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "gbk_to_utf8"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "generate_series"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            SetOfType ( ScalarType "int8" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "generate_series"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            SetOfType ( ScalarType "int4" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "generate_series"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            SetOfType ( ScalarType "int8" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "generate_series"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            SetOfType ( ScalarType "int4" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "generate_series"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            , ScalarType "interval"
>            ] (
>            SetOfType ( ScalarType "timestamp" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "generate_series"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            , ScalarType "interval"
>            ] (
>            SetOfType ( ScalarType "timestamptz" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "generate_subscripts"
>            [ Pseudo AnyArray
>            , ScalarType "int4"
>            ] (
>            SetOfType ( ScalarType "int4" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "generate_subscripts"
>            [ Pseudo AnyArray
>            , ScalarType "int4"
>            , ScalarType "bool"
>            ] (
>            SetOfType ( ScalarType "int4" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "get_bit"
>            [ ScalarType "bytea"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "get_byte"
>            [ ScalarType "bytea"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "get_current_ts_config"
>            [] (
>            ScalarType "regconfig" )
>            False
>        , EnvCreateFunction
>            FunName
>            "getdatabaseencoding"
>            [] (
>            ScalarType "name" )
>            False
>        , EnvCreateFunction
>            FunName
>            "getpgusername"
>            [] (
>            ScalarType "name" )
>            False
>        , EnvCreateFunction
>            FunName
>            "gin_cmp_prefix"
>            [ ScalarType "text"
>            , ScalarType "text"
>            , ScalarType "int2"
>            , Pseudo Internal
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "gin_cmp_tslexeme"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "gin_extract_tsquery"
>            [ ScalarType "tsquery"
>            , Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gin_extract_tsvector"
>            [ ScalarType "tsvector"
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gin_tsquery_consistent"
>            [ Pseudo Internal
>            , ScalarType "int2"
>            , ScalarType "tsquery"
>            , ScalarType "int4"
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ginarrayconsistent"
>            [ Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo AnyArray
>            , ScalarType "int4"
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ginarrayextract"
>            [ Pseudo AnyArray
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "ginbeginscan"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "ginbuild"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "ginbulkdelete"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gincostestimate"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "ginendscan"
>            [ Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "gingetbitmap"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "gininsert"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ginmarkpos"
>            [ Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "ginoptions"
>            [ ArrayType ( ScalarType "text" )
>            , ScalarType "bool"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ginqueryarrayextract"
>            [ Pseudo AnyArray
>            , Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "ginrescan"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "ginrestrpos"
>            [ Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "ginvacuumcleanup"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gist_box_compress"
>            [ Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gist_box_consistent"
>            [ Pseudo Internal
>            , ScalarType "box"
>            , ScalarType "int4"
>            , ScalarType "oid"
>            , Pseudo Internal
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "gist_box_decompress"
>            [ Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gist_box_penalty"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gist_box_picksplit"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gist_box_same"
>            [ ScalarType "box"
>            , ScalarType "box"
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gist_box_union"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            ScalarType "box" )
>            False
>        , EnvCreateFunction
>            FunName
>            "gist_circle_compress"
>            [ Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gist_circle_consistent"
>            [ Pseudo Internal
>            , ScalarType "circle"
>            , ScalarType "int4"
>            , ScalarType "oid"
>            , Pseudo Internal
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "gist_poly_compress"
>            [ Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gist_poly_consistent"
>            [ Pseudo Internal
>            , ScalarType "polygon"
>            , ScalarType "int4"
>            , ScalarType "oid"
>            , Pseudo Internal
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "gistbeginscan"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gistbuild"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gistbulkdelete"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gistcostestimate"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "gistendscan"
>            [ Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "gistgetbitmap"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "gistgettuple"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "gistinsert"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "gistmarkpos"
>            [ Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "gistoptions"
>            [ ArrayType ( ScalarType "text" )
>            , ScalarType "bool"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "gistrescan"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "gistrestrpos"
>            [ Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "gistvacuumcleanup"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gtsquery_compress"
>            [ Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gtsquery_consistent"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , ScalarType "int4"
>            , ScalarType "oid"
>            , Pseudo Internal
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "gtsquery_decompress"
>            [ Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gtsquery_penalty"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gtsquery_picksplit"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gtsquery_same"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gtsquery_union"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gtsvector_compress"
>            [ Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gtsvector_consistent"
>            [ Pseudo Internal
>            , ScalarType "gtsvector"
>            , ScalarType "int4"
>            , ScalarType "oid"
>            , Pseudo Internal
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "gtsvector_decompress"
>            [ Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gtsvector_penalty"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gtsvector_picksplit"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gtsvector_same"
>            [ ScalarType "gtsvector"
>            , ScalarType "gtsvector"
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gtsvector_union"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "gtsvectorin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "gtsvector" )
>            False
>        , EnvCreateFunction
>            FunName
>            "gtsvectorout"
>            [ ScalarType "gtsvector"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_any_column_privilege"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_any_column_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_any_column_privilege"
>            [ ScalarType "name"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_any_column_privilege"
>            [ ScalarType "name"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_any_column_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_any_column_privilege"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_column_privilege"
>            [ ScalarType "text"
>            , ScalarType "int2"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_column_privilege"
>            [ ScalarType "text"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_column_privilege"
>            [ ScalarType "oid"
>            , ScalarType "int2"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_column_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_column_privilege"
>            [ ScalarType "name"
>            , ScalarType "text"
>            , ScalarType "int2"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_column_privilege"
>            [ ScalarType "name"
>            , ScalarType "text"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_column_privilege"
>            [ ScalarType "name"
>            , ScalarType "oid"
>            , ScalarType "int2"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_column_privilege"
>            [ ScalarType "name"
>            , ScalarType "oid"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_column_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            , ScalarType "int2"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_column_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_column_privilege"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            , ScalarType "int2"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_column_privilege"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_database_privilege"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_database_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_database_privilege"
>            [ ScalarType "name"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_database_privilege"
>            [ ScalarType "name"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_database_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_database_privilege"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_foreign_data_wrapper_privilege"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_foreign_data_wrapper_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_foreign_data_wrapper_privilege"
>            [ ScalarType "name"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_foreign_data_wrapper_privilege"
>            [ ScalarType "name"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_foreign_data_wrapper_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_foreign_data_wrapper_privilege"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_function_privilege"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_function_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_function_privilege"
>            [ ScalarType "name"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_function_privilege"
>            [ ScalarType "name"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_function_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_function_privilege"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_language_privilege"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_language_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_language_privilege"
>            [ ScalarType "name"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_language_privilege"
>            [ ScalarType "name"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_language_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_language_privilege"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_schema_privilege"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_schema_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_schema_privilege"
>            [ ScalarType "name"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_schema_privilege"
>            [ ScalarType "name"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_schema_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_schema_privilege"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_server_privilege"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_server_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_server_privilege"
>            [ ScalarType "name"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_server_privilege"
>            [ ScalarType "name"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_server_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_server_privilege"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_table_privilege"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_table_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_table_privilege"
>            [ ScalarType "name"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_table_privilege"
>            [ ScalarType "name"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_table_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_table_privilege"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_tablespace_privilege"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_tablespace_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_tablespace_privilege"
>            [ ScalarType "name"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_tablespace_privilege"
>            [ ScalarType "name"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_tablespace_privilege"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "has_tablespace_privilege"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hash_aclitem"
>            [ ScalarType "aclitem"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hash_numeric"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashbeginscan"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashbpchar"
>            [ ScalarType "bpchar"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashbuild"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashbulkdelete"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashchar"
>            [ ScalarType "char"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashcostestimate"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashendscan"
>            [ Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashenum"
>            [ Pseudo AnyEnum
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashfloat4"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashfloat8"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashgetbitmap"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashgettuple"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashinet"
>            [ ScalarType "inet"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashinsert"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashint2"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashint2vector"
>            [ ScalarType "int2vector"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashint4"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashint8"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashmacaddr"
>            [ ScalarType "macaddr"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashmarkpos"
>            [ Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashname"
>            [ ScalarType "name"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashoid"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashoidvector"
>            [ ScalarType "oidvector"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashoptions"
>            [ ArrayType ( ScalarType "text" )
>            , ScalarType "bool"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashrescan"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashrestrpos"
>            [ Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashtext"
>            [ ScalarType "text"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashvacuumcleanup"
>            [ Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "hashvarlena"
>            [ Pseudo Internal
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "height"
>            [ ScalarType "box"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "host"
>            [ ScalarType "inet"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "hostmask"
>            [ ScalarType "inet"
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunName
>            "iclikejoinsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo Internal
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "iclikesel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "icnlikejoinsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo Internal
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "icnlikesel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "icregexeqjoinsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo Internal
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "icregexeqsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "icregexnejoinsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo Internal
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "icregexnesel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "inet_client_addr"
>            [] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunName
>            "inet_client_port"
>            [] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "inet_in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunName
>            "inet_out"
>            [ ScalarType "inet"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "inet_recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunName
>            "inet_send"
>            [ ScalarType "inet"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "inet_server_addr"
>            [] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunName
>            "inet_server_port"
>            [] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "inetand"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunName
>            "inetmi"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "inetmi_int8"
>            [ ScalarType "inet"
>            , ScalarType "int8"
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunName
>            "inetnot"
>            [ ScalarType "inet"
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunName
>            "inetor"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunName
>            "inetpl"
>            [ ScalarType "inet"
>            , ScalarType "int8"
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunName
>            "initcap"
>            [ ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int24div"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int24eq"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int24ge"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int24gt"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int24le"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int24lt"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int24mi"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int24mul"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int24ne"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int24pl"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int28div"
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int28eq"
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int28ge"
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int28gt"
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int28le"
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int28lt"
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int28mi"
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int28mul"
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int28ne"
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int28pl"
>            [ ScalarType "int2"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2_accum"
>            [ ArrayType ( ScalarType "numeric" )
>            , ScalarType "int2"
>            ] (
>            ArrayType ( ScalarType "numeric" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2_avg_accum"
>            [ ArrayType ( ScalarType "int8" )
>            , ScalarType "int2"
>            ] (
>            ArrayType ( ScalarType "int8" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2_mul_cash"
>            [ ScalarType "int2"
>            , ScalarType "money"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2_sum"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2abs"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2and"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2div"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2eq"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2ge"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2gt"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2larger"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2le"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2lt"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2mi"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2mod"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2mul"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2ne"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2not"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2or"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2out"
>            [ ScalarType "int2"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2pl"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2send"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2shl"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2shr"
>            [ ScalarType "int2"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2smaller"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2um"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2up"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2vectoreq"
>            [ ScalarType "int2vector"
>            , ScalarType "int2vector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2vectorin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "int2vector" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2vectorout"
>            [ ScalarType "int2vector"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2vectorrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "int2vector" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2vectorsend"
>            [ ScalarType "int2vector"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int2xor"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4"
>            [ ScalarType "bool"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4"
>            [ ScalarType "char"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4"
>            [ ScalarType "bit"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int42div"
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int42eq"
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int42ge"
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int42gt"
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int42le"
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int42lt"
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int42mi"
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int42mul"
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int42ne"
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int42pl"
>            [ ScalarType "int4"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int48div"
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int48eq"
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int48ge"
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int48gt"
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int48le"
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int48lt"
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int48mi"
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int48mul"
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int48ne"
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int48pl"
>            [ ScalarType "int4"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4_accum"
>            [ ArrayType ( ScalarType "numeric" )
>            , ScalarType "int4"
>            ] (
>            ArrayType ( ScalarType "numeric" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4_avg_accum"
>            [ ArrayType ( ScalarType "int8" )
>            , ScalarType "int4"
>            ] (
>            ArrayType ( ScalarType "int8" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4_mul_cash"
>            [ ScalarType "int4"
>            , ScalarType "money"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4_sum"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4abs"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4and"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4div"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4eq"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4ge"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4gt"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4inc"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4larger"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4le"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4lt"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4mi"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4mod"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4mul"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4ne"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4not"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4or"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4out"
>            [ ScalarType "int4"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4pl"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4send"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4shl"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4shr"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4smaller"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4um"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4up"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int4xor"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8"
>            [ ScalarType "bit"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int82div"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int82eq"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int82ge"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int82gt"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int82le"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int82lt"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int82mi"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int82mul"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int82ne"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int82pl"
>            [ ScalarType "int8"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int84div"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int84eq"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int84ge"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int84gt"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int84le"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int84lt"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int84mi"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int84mul"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int84ne"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int84pl"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8_accum"
>            [ ArrayType ( ScalarType "numeric" )
>            , ScalarType "int8"
>            ] (
>            ArrayType ( ScalarType "numeric" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8_avg"
>            [ ArrayType ( ScalarType "int8" )
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8_avg_accum"
>            [ ArrayType ( ScalarType "numeric" )
>            , ScalarType "int8"
>            ] (
>            ArrayType ( ScalarType "numeric" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8_sum"
>            [ ScalarType "numeric"
>            , ScalarType "int8"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8abs"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8and"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8div"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8eq"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8ge"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8gt"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8inc"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8inc_any"
>            [ ScalarType "int8"
>            , Pseudo Any
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8inc_float8_float8"
>            [ ScalarType "int8"
>            , ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8larger"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8le"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8lt"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8mi"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8mod"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8mul"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8ne"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8not"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8or"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8out"
>            [ ScalarType "int8"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8pl"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8pl_inet"
>            [ ScalarType "int8"
>            , ScalarType "inet"
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8send"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8shl"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8shr"
>            [ ScalarType "int8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8smaller"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8um"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8up"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "int8xor"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "integer_pl_date"
>            [ ScalarType "int4"
>            , ScalarType "date"
>            ] (
>            ScalarType "date" )
>            False
>        , EnvCreateFunction
>            FunName
>            "inter_lb"
>            [ ScalarType "line"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "inter_sb"
>            [ ScalarType "lseg"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "inter_sl"
>            [ ScalarType "lseg"
>            , ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "internal_in"
>            [ Pseudo Cstring
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "internal_out"
>            [ Pseudo Internal
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval"
>            [ ScalarType "reltime"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval"
>            [ ScalarType "time"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval"
>            [ ScalarType "interval"
>            , ScalarType "int4"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_accum"
>            [ ArrayType ( ScalarType "interval" )
>            , ScalarType "interval"
>            ] (
>            ArrayType ( ScalarType "interval" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_avg"
>            [ ArrayType ( ScalarType "interval" )
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_cmp"
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_div"
>            [ ScalarType "interval"
>            , ScalarType "float8"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_eq"
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_ge"
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_gt"
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_hash"
>            [ ScalarType "interval"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_in"
>            [ Pseudo Cstring
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_larger"
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_le"
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_lt"
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_mi"
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_mul"
>            [ ScalarType "interval"
>            , ScalarType "float8"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_ne"
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_out"
>            [ ScalarType "interval"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_pl"
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_pl_date"
>            [ ScalarType "interval"
>            , ScalarType "date"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_pl_time"
>            [ ScalarType "interval"
>            , ScalarType "time"
>            ] (
>            ScalarType "time" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_pl_timestamp"
>            [ ScalarType "interval"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_pl_timestamptz"
>            [ ScalarType "interval"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_pl_timetz"
>            [ ScalarType "interval"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "timetz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_recv"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_send"
>            [ ScalarType "interval"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_smaller"
>            [ ScalarType "interval"
>            , ScalarType "interval"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "interval_um"
>            [ ScalarType "interval"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "intervaltypmodin"
>            [ ArrayType ( Pseudo Cstring )
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "intervaltypmodout"
>            [ ScalarType "int4"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "intinterval"
>            [ ScalarType "abstime"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "isclosed"
>            [ ScalarType "path"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "isfinite"
>            [ ScalarType "abstime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "isfinite"
>            [ ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "isfinite"
>            [ ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "isfinite"
>            [ ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "isfinite"
>            [ ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ishorizontal"
>            [ ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ishorizontal"
>            [ ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ishorizontal"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "iso8859_1_to_utf8"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "iso8859_to_utf8"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "iso_to_koi8r"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "iso_to_mic"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "iso_to_win1251"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "iso_to_win866"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "isopen"
>            [ ScalarType "path"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "isparallel"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "isparallel"
>            [ ScalarType "line"
>            , ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "isperp"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "isperp"
>            [ ScalarType "line"
>            , ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "isvertical"
>            [ ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "isvertical"
>            [ ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "isvertical"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "johab_to_utf8"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "justify_days"
>            [ ScalarType "interval"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "justify_hours"
>            [ ScalarType "interval"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "justify_interval"
>            [ ScalarType "interval"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "koi8r_to_iso"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "koi8r_to_mic"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "koi8r_to_utf8"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "koi8r_to_win1251"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "koi8r_to_win866"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "koi8u_to_utf8"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "language_handler_in"
>            [ Pseudo Cstring
>            ] (
>            Pseudo LanguageHandler )
>            False
>        , EnvCreateFunction
>            FunName
>            "language_handler_out"
>            [ Pseudo LanguageHandler
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "lastval"
>            [] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "latin1_to_mic"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "latin2_to_mic"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "latin2_to_win1250"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "latin3_to_mic"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "latin4_to_mic"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "length"
>            [ ScalarType "bytea"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "length"
>            [ ScalarType "text"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "length"
>            [ ScalarType "lseg"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "length"
>            [ ScalarType "path"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "length"
>            [ ScalarType "bpchar"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "length"
>            [ ScalarType "bit"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "length"
>            [ ScalarType "tsvector"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "length"
>            [ ScalarType "bytea"
>            , ScalarType "name"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "like"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "like"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "like"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "like_escape"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "like_escape"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "likejoinsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo Internal
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "likesel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "line"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "line" )
>            False
>        , EnvCreateFunction
>            FunName
>            "line_distance"
>            [ ScalarType "line"
>            , ScalarType "line"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "line_eq"
>            [ ScalarType "line"
>            , ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "line_horizontal"
>            [ ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "line_in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "line" )
>            False
>        , EnvCreateFunction
>            FunName
>            "line_interpt"
>            [ ScalarType "line"
>            , ScalarType "line"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "line_intersect"
>            [ ScalarType "line"
>            , ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "line_out"
>            [ ScalarType "line"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "line_parallel"
>            [ ScalarType "line"
>            , ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "line_perp"
>            [ ScalarType "line"
>            , ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "line_recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "line" )
>            False
>        , EnvCreateFunction
>            FunName
>            "line_send"
>            [ ScalarType "line"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "line_vertical"
>            [ ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ln"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ln"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lo_close"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lo_creat"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "oid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lo_create"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "oid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lo_export"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lo_import"
>            [ ScalarType "text"
>            ] (
>            ScalarType "oid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lo_import"
>            [ ScalarType "text"
>            , ScalarType "oid"
>            ] (
>            ScalarType "oid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lo_lseek"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lo_open"
>            [ ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lo_tell"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lo_truncate"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lo_unlink"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "log"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "log"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "log"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "loread"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lower"
>            [ ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lowrite"
>            [ ScalarType "int4"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lpad"
>            [ ScalarType "text"
>            , ScalarType "int4"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lpad"
>            [ ScalarType "text"
>            , ScalarType "int4"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg"
>            [ ScalarType "box"
>            ] (
>            ScalarType "lseg" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "lseg" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_center"
>            [ ScalarType "lseg"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_distance"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_eq"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_ge"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_gt"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_horizontal"
>            [ ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "lseg" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_interpt"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_intersect"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_le"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_length"
>            [ ScalarType "lseg"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_lt"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_ne"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_out"
>            [ ScalarType "lseg"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_parallel"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_perp"
>            [ ScalarType "lseg"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "lseg" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_send"
>            [ ScalarType "lseg"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "lseg_vertical"
>            [ ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ltrim"
>            [ ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ltrim"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "macaddr_cmp"
>            [ ScalarType "macaddr"
>            , ScalarType "macaddr"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "macaddr_eq"
>            [ ScalarType "macaddr"
>            , ScalarType "macaddr"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "macaddr_ge"
>            [ ScalarType "macaddr"
>            , ScalarType "macaddr"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "macaddr_gt"
>            [ ScalarType "macaddr"
>            , ScalarType "macaddr"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "macaddr_in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "macaddr" )
>            False
>        , EnvCreateFunction
>            FunName
>            "macaddr_le"
>            [ ScalarType "macaddr"
>            , ScalarType "macaddr"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "macaddr_lt"
>            [ ScalarType "macaddr"
>            , ScalarType "macaddr"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "macaddr_ne"
>            [ ScalarType "macaddr"
>            , ScalarType "macaddr"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "macaddr_out"
>            [ ScalarType "macaddr"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "macaddr_recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "macaddr" )
>            False
>        , EnvCreateFunction
>            FunName
>            "macaddr_send"
>            [ ScalarType "macaddr"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "makeaclitem"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            , ScalarType "text"
>            , ScalarType "bool"
>            ] (
>            ScalarType "aclitem" )
>            False
>        , EnvCreateFunction
>            FunName
>            "masklen"
>            [ ScalarType "inet"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "md5"
>            [ ScalarType "bytea"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "md5"
>            [ ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "mic_to_ascii"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "mic_to_big5"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "mic_to_euc_cn"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "mic_to_euc_jp"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "mic_to_euc_kr"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "mic_to_euc_tw"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "mic_to_iso"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "mic_to_koi8r"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "mic_to_latin1"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "mic_to_latin2"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "mic_to_latin3"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "mic_to_latin4"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "mic_to_sjis"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "mic_to_win1250"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "mic_to_win1251"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "mic_to_win866"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "mktinterval"
>            [ ScalarType "abstime"
>            , ScalarType "abstime"
>            ] (
>            ScalarType "tinterval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "mod"
>            [ ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "mod"
>            [ ScalarType "int2"
>            , ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunName
>            "mod"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "mod"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "mul_d_interval"
>            [ ScalarType "float8"
>            , ScalarType "interval"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "name"
>            [ ScalarType "text"
>            ] (
>            ScalarType "name" )
>            False
>        , EnvCreateFunction
>            FunName
>            "name"
>            [ ScalarType "bpchar"
>            ] (
>            ScalarType "name" )
>            False
>        , EnvCreateFunction
>            FunName
>            "name"
>            [ ScalarType "varchar"
>            ] (
>            ScalarType "name" )
>            False
>        , EnvCreateFunction
>            FunName
>            "nameeq"
>            [ ScalarType "name"
>            , ScalarType "name"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "namege"
>            [ ScalarType "name"
>            , ScalarType "name"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "namegt"
>            [ ScalarType "name"
>            , ScalarType "name"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "nameiclike"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "nameicnlike"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "nameicregexeq"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "nameicregexne"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "namein"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "name" )
>            False
>        , EnvCreateFunction
>            FunName
>            "namele"
>            [ ScalarType "name"
>            , ScalarType "name"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "namelike"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "namelt"
>            [ ScalarType "name"
>            , ScalarType "name"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "namene"
>            [ ScalarType "name"
>            , ScalarType "name"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "namenlike"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "nameout"
>            [ ScalarType "name"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "namerecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "name" )
>            False
>        , EnvCreateFunction
>            FunName
>            "nameregexeq"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "nameregexne"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "namesend"
>            [ ScalarType "name"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "neqjoinsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo Internal
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "neqsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "netmask"
>            [ ScalarType "inet"
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunName
>            "network"
>            [ ScalarType "inet"
>            ] (
>            ScalarType "cidr" )
>            False
>        , EnvCreateFunction
>            FunName
>            "network_cmp"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "network_eq"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "network_ge"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "network_gt"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "network_le"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "network_lt"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "network_ne"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "network_sub"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "network_subeq"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "network_sup"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "network_supeq"
>            [ ScalarType "inet"
>            , ScalarType "inet"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "nextval"
>            [ ScalarType "regclass"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "nlikejoinsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo Internal
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "nlikesel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "notlike"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "notlike"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "notlike"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "now"
>            [] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "npoints"
>            [ ScalarType "path"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "npoints"
>            [ ScalarType "polygon"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric"
>            [ ScalarType "numeric"
>            , ScalarType "int4"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_abs"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_accum"
>            [ ArrayType ( ScalarType "numeric" )
>            , ScalarType "numeric"
>            ] (
>            ArrayType ( ScalarType "numeric" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_add"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_avg"
>            [ ArrayType ( ScalarType "numeric" )
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_avg_accum"
>            [ ArrayType ( ScalarType "numeric" )
>            , ScalarType "numeric"
>            ] (
>            ArrayType ( ScalarType "numeric" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_cmp"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_div"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_div_trunc"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_eq"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_exp"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_fac"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_ge"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_gt"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_in"
>            [ Pseudo Cstring
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_inc"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_larger"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_le"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_ln"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_log"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_lt"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_mod"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_mul"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_ne"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_out"
>            [ ScalarType "numeric"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_power"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_recv"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_send"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_smaller"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_sqrt"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_stddev_pop"
>            [ ArrayType ( ScalarType "numeric" )
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_stddev_samp"
>            [ ArrayType ( ScalarType "numeric" )
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_sub"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_uminus"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_uplus"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_var_pop"
>            [ ArrayType ( ScalarType "numeric" )
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numeric_var_samp"
>            [ ArrayType ( ScalarType "numeric" )
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numerictypmodin"
>            [ ArrayType ( Pseudo Cstring )
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "numerictypmodout"
>            [ ScalarType "int4"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "numnode"
>            [ ScalarType "tsquery"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "obj_description"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "obj_description"
>            [ ScalarType "oid"
>            , ScalarType "name"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "octet_length"
>            [ ScalarType "bytea"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "octet_length"
>            [ ScalarType "text"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "octet_length"
>            [ ScalarType "bpchar"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "octet_length"
>            [ ScalarType "bit"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oid"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "oid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oideq"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidge"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidgt"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "oid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidlarger"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            ] (
>            ScalarType "oid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidle"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidlt"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidne"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidout"
>            [ ScalarType "oid"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "oid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidsend"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidsmaller"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            ] (
>            ScalarType "oid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidvectoreq"
>            [ ScalarType "oidvector"
>            , ScalarType "oidvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidvectorge"
>            [ ScalarType "oidvector"
>            , ScalarType "oidvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidvectorgt"
>            [ ScalarType "oidvector"
>            , ScalarType "oidvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidvectorin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "oidvector" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidvectorle"
>            [ ScalarType "oidvector"
>            , ScalarType "oidvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidvectorlt"
>            [ ScalarType "oidvector"
>            , ScalarType "oidvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidvectorne"
>            [ ScalarType "oidvector"
>            , ScalarType "oidvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidvectorout"
>            [ ScalarType "oidvector"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidvectorrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "oidvector" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidvectorsend"
>            [ ScalarType "oidvector"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "oidvectortypes"
>            [ ScalarType "oidvector"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "on_pb"
>            [ ScalarType "point"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "on_pl"
>            [ ScalarType "point"
>            , ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "on_ppath"
>            [ ScalarType "point"
>            , ScalarType "path"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "on_ps"
>            [ ScalarType "point"
>            , ScalarType "lseg"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "on_sb"
>            [ ScalarType "lseg"
>            , ScalarType "box"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "on_sl"
>            [ ScalarType "lseg"
>            , ScalarType "line"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "opaque_in"
>            [ Pseudo Cstring
>            ] (
>            Pseudo Opaque )
>            False
>        , EnvCreateFunction
>            FunName
>            "opaque_out"
>            [ Pseudo Opaque
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "overlaps"
>            [ ScalarType "time"
>            , ScalarType "time"
>            , ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "overlaps"
>            [ ScalarType "time"
>            , ScalarType "time"
>            , ScalarType "time"
>            , ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "overlaps"
>            [ ScalarType "time"
>            , ScalarType "interval"
>            , ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "overlaps"
>            [ ScalarType "time"
>            , ScalarType "interval"
>            , ScalarType "time"
>            , ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "overlaps"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            , ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "overlaps"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            , ScalarType "timestamp"
>            , ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "overlaps"
>            [ ScalarType "timestamp"
>            , ScalarType "interval"
>            , ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "overlaps"
>            [ ScalarType "timestamp"
>            , ScalarType "interval"
>            , ScalarType "timestamp"
>            , ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "overlaps"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "overlaps"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            , ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "overlaps"
>            [ ScalarType "timestamptz"
>            , ScalarType "interval"
>            , ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "overlaps"
>            [ ScalarType "timestamptz"
>            , ScalarType "interval"
>            , ScalarType "timestamptz"
>            , ScalarType "interval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "overlaps"
>            [ ScalarType "timetz"
>            , ScalarType "timetz"
>            , ScalarType "timetz"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "overlay"
>            [ ScalarType "text"
>            , ScalarType "text"
>            , ScalarType "int4"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "overlay"
>            [ ScalarType "text"
>            , ScalarType "text"
>            , ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path"
>            [ ScalarType "polygon"
>            ] (
>            ScalarType "path" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_add"
>            [ ScalarType "path"
>            , ScalarType "path"
>            ] (
>            ScalarType "path" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_add_pt"
>            [ ScalarType "path"
>            , ScalarType "point"
>            ] (
>            ScalarType "path" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_center"
>            [ ScalarType "path"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_contain_pt"
>            [ ScalarType "path"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_distance"
>            [ ScalarType "path"
>            , ScalarType "path"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_div_pt"
>            [ ScalarType "path"
>            , ScalarType "point"
>            ] (
>            ScalarType "path" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "path" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_inter"
>            [ ScalarType "path"
>            , ScalarType "path"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_length"
>            [ ScalarType "path"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_mul_pt"
>            [ ScalarType "path"
>            , ScalarType "point"
>            ] (
>            ScalarType "path" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_n_eq"
>            [ ScalarType "path"
>            , ScalarType "path"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_n_ge"
>            [ ScalarType "path"
>            , ScalarType "path"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_n_gt"
>            [ ScalarType "path"
>            , ScalarType "path"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_n_le"
>            [ ScalarType "path"
>            , ScalarType "path"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_n_lt"
>            [ ScalarType "path"
>            , ScalarType "path"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_npoints"
>            [ ScalarType "path"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_out"
>            [ ScalarType "path"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "path" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_send"
>            [ ScalarType "path"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "path_sub_pt"
>            [ ScalarType "path"
>            , ScalarType "point"
>            ] (
>            ScalarType "path" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pclose"
>            [ ScalarType "path"
>            ] (
>            ScalarType "path" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_advisory_lock"
>            [ ScalarType "int8"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_advisory_lock"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_advisory_lock_shared"
>            [ ScalarType "int8"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_advisory_lock_shared"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_advisory_unlock"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_advisory_unlock"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_advisory_unlock_all"
>            [] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_advisory_unlock_shared"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_advisory_unlock_shared"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_backend_pid"
>            [] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_cancel_backend"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_char_to_encoding"
>            [ ScalarType "name"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_client_encoding"
>            [] (
>            ScalarType "name" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_column_size"
>            [ Pseudo Any
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_conf_load_time"
>            [] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_conversion_is_visible"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_current_xlog_insert_location"
>            [] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_current_xlog_location"
>            [] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_cursor"
>            [] (
>            SetOfType ( Pseudo Record ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_database_size"
>            [ ScalarType "name"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_database_size"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_encoding_to_char"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "name" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_function_is_visible"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_constraintdef"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_constraintdef"
>            [ ScalarType "oid"
>            , ScalarType "bool"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_expr"
>            [ ScalarType "text"
>            , ScalarType "oid"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_expr"
>            [ ScalarType "text"
>            , ScalarType "oid"
>            , ScalarType "bool"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_function_arguments"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_function_identity_arguments"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_function_result"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_functiondef"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_indexdef"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_indexdef"
>            [ ScalarType "oid"
>            , ScalarType "int4"
>            , ScalarType "bool"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_keywords"
>            [] (
>            SetOfType ( Pseudo Record ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_ruledef"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_ruledef"
>            [ ScalarType "oid"
>            , ScalarType "bool"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_serial_sequence"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_triggerdef"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_userbyid"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "name" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_viewdef"
>            [ ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_viewdef"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_viewdef"
>            [ ScalarType "text"
>            , ScalarType "bool"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_get_viewdef"
>            [ ScalarType "oid"
>            , ScalarType "bool"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_has_role"
>            [ ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_has_role"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_has_role"
>            [ ScalarType "name"
>            , ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_has_role"
>            [ ScalarType "name"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_has_role"
>            [ ScalarType "oid"
>            , ScalarType "name"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_has_role"
>            [ ScalarType "oid"
>            , ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_is_other_temp_schema"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_lock_status"
>            [] (
>            SetOfType ( Pseudo Record ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_ls_dir"
>            [ ScalarType "text"
>            ] (
>            SetOfType ( ScalarType "text" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_my_temp_schema"
>            [] (
>            ScalarType "oid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_opclass_is_visible"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_operator_is_visible"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_options_to_table"
>            [ ArrayType ( ScalarType "text" )
>            ] (
>            SetOfType ( Pseudo Record ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_postmaster_start_time"
>            [] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_prepared_statement"
>            [] (
>            SetOfType ( Pseudo Record ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_prepared_xact"
>            [] (
>            SetOfType ( Pseudo Record ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_read_file"
>            [ ScalarType "text"
>            , ScalarType "int8"
>            , ScalarType "int8"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_relation_size"
>            [ ScalarType "regclass"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_relation_size"
>            [ ScalarType "regclass"
>            , ScalarType "text"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_reload_conf"
>            [] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_rotate_logfile"
>            [] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_show_all_settings"
>            [] (
>            SetOfType ( Pseudo Record ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_size_pretty"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_sleep"
>            [ ScalarType "float8"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_start_backup"
>            [ ScalarType "text"
>            , ScalarType "bool"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_clear_snapshot"
>            [] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_file"
>            [ ScalarType "text"
>            ] (
>            Pseudo Record )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_activity"
>            [ ScalarType "int4"
>            ] (
>            SetOfType ( Pseudo Record ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_backend_activity"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_backend_activity_start"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_backend_client_addr"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_backend_client_port"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_backend_dbid"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "oid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_backend_idset"
>            [] (
>            SetOfType ( ScalarType "int4" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_backend_pid"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_backend_start"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_backend_userid"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "oid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_backend_waiting"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_backend_xact_start"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_bgwriter_buf_written_checkpoints"
>            [] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_bgwriter_buf_written_clean"
>            [] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_bgwriter_maxwritten_clean"
>            [] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_bgwriter_requested_checkpoints"
>            [] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_bgwriter_timed_checkpoints"
>            [] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_blocks_fetched"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_blocks_hit"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_buf_alloc"
>            [] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_buf_written_backend"
>            [] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_db_blocks_fetched"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_db_blocks_hit"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_db_numbackends"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_db_tuples_deleted"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_db_tuples_fetched"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_db_tuples_inserted"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_db_tuples_returned"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_db_tuples_updated"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_db_xact_commit"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_db_xact_rollback"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_dead_tuples"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_function_calls"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_function_self_time"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_function_time"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_last_analyze_time"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_last_autoanalyze_time"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_last_autovacuum_time"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_last_vacuum_time"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_live_tuples"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_numscans"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_tuples_deleted"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_tuples_fetched"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_tuples_hot_updated"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_tuples_inserted"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_tuples_returned"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_get_tuples_updated"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stat_reset"
>            [] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_stop_backup"
>            [] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_switch_xlog"
>            [] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_table_is_visible"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_tablespace_databases"
>            [ ScalarType "oid"
>            ] (
>            SetOfType ( ScalarType "oid" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_tablespace_size"
>            [ ScalarType "name"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_tablespace_size"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_terminate_backend"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_timezone_abbrevs"
>            [] (
>            SetOfType ( Pseudo Record ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_timezone_names"
>            [] (
>            SetOfType ( Pseudo Record ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_total_relation_size"
>            [ ScalarType "regclass"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_try_advisory_lock"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_try_advisory_lock"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_try_advisory_lock_shared"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_try_advisory_lock_shared"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_ts_config_is_visible"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_ts_dict_is_visible"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_ts_parser_is_visible"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_ts_template_is_visible"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_type_is_visible"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_typeof"
>            [ Pseudo Any
>            ] (
>            ScalarType "regtype" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_xlogfile_name"
>            [ ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pg_xlogfile_name_offset"
>            [ ScalarType "text"
>            ] (
>            Pseudo Record )
>            False
>        , EnvCreateFunction
>            FunName
>            "pi"
>            [] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "plainto_tsquery"
>            [ ScalarType "text"
>            ] (
>            ScalarType "tsquery" )
>            False
>        , EnvCreateFunction
>            FunName
>            "plainto_tsquery"
>            [ ScalarType "regconfig"
>            , ScalarType "text"
>            ] (
>            ScalarType "tsquery" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point"
>            [ ScalarType "lseg"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point"
>            [ ScalarType "path"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point"
>            [ ScalarType "box"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point"
>            [ ScalarType "polygon"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point"
>            [ ScalarType "circle"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point_above"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point_add"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point_below"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point_distance"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point_div"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point_eq"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point_horiz"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point_in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point_left"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point_mul"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point_ne"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point_out"
>            [ ScalarType "point"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "point_recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point_right"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point_send"
>            [ ScalarType "point"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point_sub"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "point_vert"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_above"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_below"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_center"
>            [ ScalarType "polygon"
>            ] (
>            ScalarType "point" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_contain"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_contain_pt"
>            [ ScalarType "polygon"
>            , ScalarType "point"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_contained"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_distance"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "polygon" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_left"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_npoints"
>            [ ScalarType "polygon"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_out"
>            [ ScalarType "polygon"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_overabove"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_overbelow"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_overlap"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_overleft"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_overright"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "polygon" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_right"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_same"
>            [ ScalarType "polygon"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "poly_send"
>            [ ScalarType "polygon"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "polygon"
>            [ ScalarType "path"
>            ] (
>            ScalarType "polygon" )
>            False
>        , EnvCreateFunction
>            FunName
>            "polygon"
>            [ ScalarType "box"
>            ] (
>            ScalarType "polygon" )
>            False
>        , EnvCreateFunction
>            FunName
>            "polygon"
>            [ ScalarType "circle"
>            ] (
>            ScalarType "polygon" )
>            False
>        , EnvCreateFunction
>            FunName
>            "polygon"
>            [ ScalarType "int4"
>            , ScalarType "circle"
>            ] (
>            ScalarType "polygon" )
>            False
>        , EnvCreateFunction
>            FunName
>            "popen"
>            [ ScalarType "path"
>            ] (
>            ScalarType "path" )
>            False
>        , EnvCreateFunction
>            FunName
>            "position"
>            [ ScalarType "bytea"
>            , ScalarType "bytea"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "position"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "position"
>            [ ScalarType "bit"
>            , ScalarType "bit"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "positionjoinsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo Internal
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "positionsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "postgresql_fdw_validator"
>            [ ArrayType ( ScalarType "text" )
>            , ScalarType "oid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pow"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pow"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "power"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "power"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "prsd_end"
>            [ Pseudo Internal
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "prsd_headline"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , ScalarType "tsquery"
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "prsd_lextype"
>            [ Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "prsd_nexttoken"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "prsd_start"
>            [ Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "pt_contained_circle"
>            [ ScalarType "point"
>            , ScalarType "circle"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "pt_contained_poly"
>            [ ScalarType "point"
>            , ScalarType "polygon"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "query_to_xml"
>            [ ScalarType "text"
>            , ScalarType "bool"
>            , ScalarType "bool"
>            , ScalarType "text"
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "query_to_xml_and_xmlschema"
>            [ ScalarType "text"
>            , ScalarType "bool"
>            , ScalarType "bool"
>            , ScalarType "text"
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "query_to_xmlschema"
>            [ ScalarType "text"
>            , ScalarType "bool"
>            , ScalarType "bool"
>            , ScalarType "text"
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "querytree"
>            [ ScalarType "tsquery"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "quote_ident"
>            [ ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "quote_literal"
>            [ ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "quote_literal"
>            [ Pseudo AnyElement
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "quote_nullable"
>            [ ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "quote_nullable"
>            [ Pseudo AnyElement
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "radians"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "radius"
>            [ ScalarType "circle"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "random"
>            [] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "record_eq"
>            [ Pseudo Record
>            , Pseudo Record
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "record_ge"
>            [ Pseudo Record
>            , Pseudo Record
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "record_gt"
>            [ Pseudo Record
>            , Pseudo Record
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "record_in"
>            [ Pseudo Cstring
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            Pseudo Record )
>            False
>        , EnvCreateFunction
>            FunName
>            "record_le"
>            [ Pseudo Record
>            , Pseudo Record
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "record_lt"
>            [ Pseudo Record
>            , Pseudo Record
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "record_ne"
>            [ Pseudo Record
>            , Pseudo Record
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "record_out"
>            [ Pseudo Record
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "record_recv"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            Pseudo Record )
>            False
>        , EnvCreateFunction
>            FunName
>            "record_send"
>            [ Pseudo Record
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regclass"
>            [ ScalarType "text"
>            ] (
>            ScalarType "regclass" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regclassin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "regclass" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regclassout"
>            [ ScalarType "regclass"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "regclassrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "regclass" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regclasssend"
>            [ ScalarType "regclass"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regconfigin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "regconfig" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regconfigout"
>            [ ScalarType "regconfig"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "regconfigrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "regconfig" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regconfigsend"
>            [ ScalarType "regconfig"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regdictionaryin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "regdictionary" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regdictionaryout"
>            [ ScalarType "regdictionary"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "regdictionaryrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "regdictionary" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regdictionarysend"
>            [ ScalarType "regdictionary"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regexeqjoinsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo Internal
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regexeqsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regexnejoinsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo Internal
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regexnesel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regexp_matches"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            SetOfType ( ArrayType ( ScalarType "text" ) ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "regexp_matches"
>            [ ScalarType "text"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            SetOfType ( ArrayType ( ScalarType "text" ) ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "regexp_replace"
>            [ ScalarType "text"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regexp_replace"
>            [ ScalarType "text"
>            , ScalarType "text"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regexp_split_to_array"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ArrayType ( ScalarType "text" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "regexp_split_to_array"
>            [ ScalarType "text"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ArrayType ( ScalarType "text" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "regexp_split_to_table"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            SetOfType ( ScalarType "text" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "regexp_split_to_table"
>            [ ScalarType "text"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            SetOfType ( ScalarType "text" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "regoperatorin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "regoperator" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regoperatorout"
>            [ ScalarType "regoperator"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "regoperatorrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "regoperator" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regoperatorsend"
>            [ ScalarType "regoperator"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regoperin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "regoper" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regoperout"
>            [ ScalarType "regoper"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "regoperrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "regoper" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regopersend"
>            [ ScalarType "regoper"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regprocedurein"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "regprocedure" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regprocedureout"
>            [ ScalarType "regprocedure"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "regprocedurerecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "regprocedure" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regproceduresend"
>            [ ScalarType "regprocedure"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regprocin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "regproc" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regprocout"
>            [ ScalarType "regproc"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "regprocrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "regproc" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regprocsend"
>            [ ScalarType "regproc"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regtypein"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "regtype" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regtypeout"
>            [ ScalarType "regtype"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "regtyperecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "regtype" )
>            False
>        , EnvCreateFunction
>            FunName
>            "regtypesend"
>            [ ScalarType "regtype"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "reltime"
>            [ ScalarType "interval"
>            ] (
>            ScalarType "reltime" )
>            False
>        , EnvCreateFunction
>            FunName
>            "reltimeeq"
>            [ ScalarType "reltime"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "reltimege"
>            [ ScalarType "reltime"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "reltimegt"
>            [ ScalarType "reltime"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "reltimein"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "reltime" )
>            False
>        , EnvCreateFunction
>            FunName
>            "reltimele"
>            [ ScalarType "reltime"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "reltimelt"
>            [ ScalarType "reltime"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "reltimene"
>            [ ScalarType "reltime"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "reltimeout"
>            [ ScalarType "reltime"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "reltimerecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "reltime" )
>            False
>        , EnvCreateFunction
>            FunName
>            "reltimesend"
>            [ ScalarType "reltime"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "repeat"
>            [ ScalarType "text"
>            , ScalarType "int4"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "replace"
>            [ ScalarType "text"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "round"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "round"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "round"
>            [ ScalarType "numeric"
>            , ScalarType "int4"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "rpad"
>            [ ScalarType "text"
>            , ScalarType "int4"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "rpad"
>            [ ScalarType "text"
>            , ScalarType "int4"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "rtrim"
>            [ ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "rtrim"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "scalargtjoinsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo Internal
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "scalargtsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "scalarltjoinsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo Internal
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "scalarltsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "schema_to_xml"
>            [ ScalarType "name"
>            , ScalarType "bool"
>            , ScalarType "bool"
>            , ScalarType "text"
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "schema_to_xml_and_xmlschema"
>            [ ScalarType "name"
>            , ScalarType "bool"
>            , ScalarType "bool"
>            , ScalarType "text"
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "schema_to_xmlschema"
>            [ ScalarType "name"
>            , ScalarType "bool"
>            , ScalarType "bool"
>            , ScalarType "text"
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "session_user"
>            [] (
>            ScalarType "name" )
>            False
>        , EnvCreateFunction
>            FunName
>            "set_bit"
>            [ ScalarType "bytea"
>            , ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "set_byte"
>            [ ScalarType "bytea"
>            , ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "set_config"
>            [ ScalarType "text"
>            , ScalarType "text"
>            , ScalarType "bool"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "set_masklen"
>            [ ScalarType "cidr"
>            , ScalarType "int4"
>            ] (
>            ScalarType "cidr" )
>            False
>        , EnvCreateFunction
>            FunName
>            "set_masklen"
>            [ ScalarType "inet"
>            , ScalarType "int4"
>            ] (
>            ScalarType "inet" )
>            False
>        , EnvCreateFunction
>            FunName
>            "setseed"
>            [ ScalarType "float8"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "setval"
>            [ ScalarType "regclass"
>            , ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "setval"
>            [ ScalarType "regclass"
>            , ScalarType "int8"
>            , ScalarType "bool"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "setweight"
>            [ ScalarType "tsvector"
>            , ScalarType "char"
>            ] (
>            ScalarType "tsvector" )
>            False
>        , EnvCreateFunction
>            FunName
>            "shell_in"
>            [ Pseudo Cstring
>            ] (
>            Pseudo Opaque )
>            False
>        , EnvCreateFunction
>            FunName
>            "shell_out"
>            [ Pseudo Opaque
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "shift_jis_2004_to_euc_jis_2004"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "shift_jis_2004_to_utf8"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "shobj_description"
>            [ ScalarType "oid"
>            , ScalarType "name"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "sign"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "sign"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "similar_escape"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "sin"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "sjis_to_euc_jp"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "sjis_to_mic"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "sjis_to_utf8"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "slope"
>            [ ScalarType "point"
>            , ScalarType "point"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "smgreq"
>            [ ScalarType "smgr"
>            , ScalarType "smgr"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "smgrin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "smgr" )
>            False
>        , EnvCreateFunction
>            FunName
>            "smgrne"
>            [ ScalarType "smgr"
>            , ScalarType "smgr"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "smgrout"
>            [ ScalarType "smgr"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "split_part"
>            [ ScalarType "text"
>            , ScalarType "text"
>            , ScalarType "int4"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "sqrt"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "sqrt"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "statement_timestamp"
>            [] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "string_to_array"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ArrayType ( ScalarType "text" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "strip"
>            [ ScalarType "tsvector"
>            ] (
>            ScalarType "tsvector" )
>            False
>        , EnvCreateFunction
>            FunName
>            "strpos"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "substr"
>            [ ScalarType "bytea"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "substr"
>            [ ScalarType "text"
>            , ScalarType "int4"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "substr"
>            [ ScalarType "bytea"
>            , ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "substr"
>            [ ScalarType "text"
>            , ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "substring"
>            [ ScalarType "bytea"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "substring"
>            [ ScalarType "text"
>            , ScalarType "int4"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "substring"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "substring"
>            [ ScalarType "bit"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunName
>            "substring"
>            [ ScalarType "bytea"
>            , ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "substring"
>            [ ScalarType "text"
>            , ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "substring"
>            [ ScalarType "text"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "substring"
>            [ ScalarType "bit"
>            , ScalarType "int4"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunName
>            "suppress_redundant_updates_trigger"
>            [] (
>            Pseudo Trigger )
>            False
>        , EnvCreateFunction
>            FunName
>            "table_to_xml"
>            [ ScalarType "regclass"
>            , ScalarType "bool"
>            , ScalarType "bool"
>            , ScalarType "text"
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "table_to_xml_and_xmlschema"
>            [ ScalarType "regclass"
>            , ScalarType "bool"
>            , ScalarType "bool"
>            , ScalarType "text"
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "table_to_xmlschema"
>            [ ScalarType "regclass"
>            , ScalarType "bool"
>            , ScalarType "bool"
>            , ScalarType "text"
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tan"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "text"
>            [ ScalarType "bool"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "text"
>            [ ScalarType "char"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "text"
>            [ ScalarType "name"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "text"
>            [ ScalarType "xml"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "text"
>            [ ScalarType "inet"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "text"
>            [ ScalarType "bpchar"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "text_ge"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "text_gt"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "text_larger"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "text_le"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "text_lt"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "text_pattern_ge"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "text_pattern_gt"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "text_pattern_le"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "text_pattern_lt"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "text_smaller"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "textanycat"
>            [ ScalarType "text"
>            , Pseudo AnyNonArray
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "textcat"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "texteq"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "texticlike"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "texticnlike"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "texticregexeq"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "texticregexne"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "textin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "textlen"
>            [ ScalarType "text"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "textlike"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "textne"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "textnlike"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "textout"
>            [ ScalarType "text"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "textrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "textregexeq"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "textregexne"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "textsend"
>            [ ScalarType "text"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "thesaurus_init"
>            [ Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "thesaurus_lexize"
>            [ Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            , Pseudo Internal
>            ] (
>            Pseudo Internal )
>            False
>        , EnvCreateFunction
>            FunName
>            "tideq"
>            [ ScalarType "tid"
>            , ScalarType "tid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tidge"
>            [ ScalarType "tid"
>            , ScalarType "tid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tidgt"
>            [ ScalarType "tid"
>            , ScalarType "tid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tidin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "tid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tidlarger"
>            [ ScalarType "tid"
>            , ScalarType "tid"
>            ] (
>            ScalarType "tid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tidle"
>            [ ScalarType "tid"
>            , ScalarType "tid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tidlt"
>            [ ScalarType "tid"
>            , ScalarType "tid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tidne"
>            [ ScalarType "tid"
>            , ScalarType "tid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tidout"
>            [ ScalarType "tid"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "tidrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "tid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tidsend"
>            [ ScalarType "tid"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tidsmaller"
>            [ ScalarType "tid"
>            , ScalarType "tid"
>            ] (
>            ScalarType "tid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time"
>            [ ScalarType "abstime"
>            ] (
>            ScalarType "time" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time"
>            [ ScalarType "timestamp"
>            ] (
>            ScalarType "time" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time"
>            [ ScalarType "timestamptz"
>            ] (
>            ScalarType "time" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time"
>            [ ScalarType "interval"
>            ] (
>            ScalarType "time" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time"
>            [ ScalarType "timetz"
>            ] (
>            ScalarType "time" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time"
>            [ ScalarType "time"
>            , ScalarType "int4"
>            ] (
>            ScalarType "time" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time_cmp"
>            [ ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time_eq"
>            [ ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time_ge"
>            [ ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time_gt"
>            [ ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time_hash"
>            [ ScalarType "time"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time_in"
>            [ Pseudo Cstring
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "time" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time_larger"
>            [ ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "time" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time_le"
>            [ ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time_lt"
>            [ ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time_mi_interval"
>            [ ScalarType "time"
>            , ScalarType "interval"
>            ] (
>            ScalarType "time" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time_mi_time"
>            [ ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time_ne"
>            [ ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time_out"
>            [ ScalarType "time"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "time_pl_interval"
>            [ ScalarType "time"
>            , ScalarType "interval"
>            ] (
>            ScalarType "time" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time_recv"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "time" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time_send"
>            [ ScalarType "time"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "time_smaller"
>            [ ScalarType "time"
>            , ScalarType "time"
>            ] (
>            ScalarType "time" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timedate_pl"
>            [ ScalarType "time"
>            , ScalarType "date"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timemi"
>            [ ScalarType "abstime"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "abstime" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timenow"
>            [] (
>            ScalarType "abstime" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timeofday"
>            [] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timepl"
>            [ ScalarType "abstime"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "abstime" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp"
>            [ ScalarType "abstime"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp"
>            [ ScalarType "date"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp"
>            [ ScalarType "timestamptz"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp"
>            [ ScalarType "date"
>            , ScalarType "time"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp"
>            [ ScalarType "timestamp"
>            , ScalarType "int4"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_cmp"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_cmp_date"
>            [ ScalarType "timestamp"
>            , ScalarType "date"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_cmp_timestamptz"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_eq"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_eq_date"
>            [ ScalarType "timestamp"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_eq_timestamptz"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_ge"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_ge_date"
>            [ ScalarType "timestamp"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_ge_timestamptz"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_gt"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_gt_date"
>            [ ScalarType "timestamp"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_gt_timestamptz"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_hash"
>            [ ScalarType "timestamp"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_in"
>            [ Pseudo Cstring
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_larger"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_le"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_le_date"
>            [ ScalarType "timestamp"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_le_timestamptz"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_lt"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_lt_date"
>            [ ScalarType "timestamp"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_lt_timestamptz"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_mi"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_mi_interval"
>            [ ScalarType "timestamp"
>            , ScalarType "interval"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_ne"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_ne_date"
>            [ ScalarType "timestamp"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_ne_timestamptz"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_out"
>            [ ScalarType "timestamp"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_pl_interval"
>            [ ScalarType "timestamp"
>            , ScalarType "interval"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_recv"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_send"
>            [ ScalarType "timestamp"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamp_smaller"
>            [ ScalarType "timestamp"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptypmodin"
>            [ ArrayType ( Pseudo Cstring )
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptypmodout"
>            [ ScalarType "int4"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz"
>            [ ScalarType "abstime"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz"
>            [ ScalarType "date"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz"
>            [ ScalarType "timestamp"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz"
>            [ ScalarType "date"
>            , ScalarType "time"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz"
>            [ ScalarType "date"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz"
>            [ ScalarType "timestamptz"
>            , ScalarType "int4"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_cmp"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_cmp_date"
>            [ ScalarType "timestamptz"
>            , ScalarType "date"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_cmp_timestamp"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_eq"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_eq_date"
>            [ ScalarType "timestamptz"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_eq_timestamp"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_ge"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_ge_date"
>            [ ScalarType "timestamptz"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_ge_timestamp"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_gt"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_gt_date"
>            [ ScalarType "timestamptz"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_gt_timestamp"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_in"
>            [ Pseudo Cstring
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_larger"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_le"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_le_date"
>            [ ScalarType "timestamptz"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_le_timestamp"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_lt"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_lt_date"
>            [ ScalarType "timestamptz"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_lt_timestamp"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_mi"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_mi_interval"
>            [ ScalarType "timestamptz"
>            , ScalarType "interval"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_ne"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_ne_date"
>            [ ScalarType "timestamptz"
>            , ScalarType "date"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_ne_timestamp"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_out"
>            [ ScalarType "timestamptz"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_pl_interval"
>            [ ScalarType "timestamptz"
>            , ScalarType "interval"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_recv"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_send"
>            [ ScalarType "timestamptz"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptz_smaller"
>            [ ScalarType "timestamptz"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptztypmodin"
>            [ ArrayType ( Pseudo Cstring )
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timestamptztypmodout"
>            [ ScalarType "int4"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetypmodin"
>            [ ArrayType ( Pseudo Cstring )
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetypmodout"
>            [ ScalarType "int4"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz"
>            [ ScalarType "time"
>            ] (
>            ScalarType "timetz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz"
>            [ ScalarType "timestamptz"
>            ] (
>            ScalarType "timetz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz"
>            [ ScalarType "timetz"
>            , ScalarType "int4"
>            ] (
>            ScalarType "timetz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz_cmp"
>            [ ScalarType "timetz"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz_eq"
>            [ ScalarType "timetz"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz_ge"
>            [ ScalarType "timetz"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz_gt"
>            [ ScalarType "timetz"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz_hash"
>            [ ScalarType "timetz"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz_in"
>            [ Pseudo Cstring
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "timetz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz_larger"
>            [ ScalarType "timetz"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "timetz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz_le"
>            [ ScalarType "timetz"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz_lt"
>            [ ScalarType "timetz"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz_mi_interval"
>            [ ScalarType "timetz"
>            , ScalarType "interval"
>            ] (
>            ScalarType "timetz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz_ne"
>            [ ScalarType "timetz"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz_out"
>            [ ScalarType "timetz"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz_pl_interval"
>            [ ScalarType "timetz"
>            , ScalarType "interval"
>            ] (
>            ScalarType "timetz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz_recv"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "timetz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz_send"
>            [ ScalarType "timetz"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetz_smaller"
>            [ ScalarType "timetz"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "timetz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetzdate_pl"
>            [ ScalarType "timetz"
>            , ScalarType "date"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetztypmodin"
>            [ ArrayType ( Pseudo Cstring )
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timetztypmodout"
>            [ ScalarType "int4"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "timezone"
>            [ ScalarType "text"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timezone"
>            [ ScalarType "text"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timezone"
>            [ ScalarType "text"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "timetz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timezone"
>            [ ScalarType "interval"
>            , ScalarType "timestamp"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timezone"
>            [ ScalarType "interval"
>            , ScalarType "timestamptz"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunName
>            "timezone"
>            [ ScalarType "interval"
>            , ScalarType "timetz"
>            ] (
>            ScalarType "timetz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tinterval"
>            [ ScalarType "abstime"
>            , ScalarType "abstime"
>            ] (
>            ScalarType "tinterval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervalct"
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervalend"
>            [ ScalarType "tinterval"
>            ] (
>            ScalarType "abstime" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervaleq"
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervalge"
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervalgt"
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervalin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "tinterval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervalle"
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervalleneq"
>            [ ScalarType "tinterval"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervallenge"
>            [ ScalarType "tinterval"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervallengt"
>            [ ScalarType "tinterval"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervallenle"
>            [ ScalarType "tinterval"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervallenlt"
>            [ ScalarType "tinterval"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervallenne"
>            [ ScalarType "tinterval"
>            , ScalarType "reltime"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervallt"
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervalne"
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervalout"
>            [ ScalarType "tinterval"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervalov"
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervalrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "tinterval" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervalrel"
>            [ ScalarType "tinterval"
>            ] (
>            ScalarType "reltime" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervalsame"
>            [ ScalarType "tinterval"
>            , ScalarType "tinterval"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervalsend"
>            [ ScalarType "tinterval"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tintervalstart"
>            [ ScalarType "tinterval"
>            ] (
>            ScalarType "abstime" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_ascii"
>            [ ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_ascii"
>            [ ScalarType "text"
>            , ScalarType "name"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_ascii"
>            [ ScalarType "text"
>            , ScalarType "int4"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_char"
>            [ ScalarType "int8"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_char"
>            [ ScalarType "int4"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_char"
>            [ ScalarType "float4"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_char"
>            [ ScalarType "float8"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_char"
>            [ ScalarType "timestamp"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_char"
>            [ ScalarType "timestamptz"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_char"
>            [ ScalarType "interval"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_char"
>            [ ScalarType "numeric"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_date"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "date" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_hex"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_hex"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_number"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_timestamp"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_timestamp"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_tsquery"
>            [ ScalarType "text"
>            ] (
>            ScalarType "tsquery" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_tsquery"
>            [ ScalarType "regconfig"
>            , ScalarType "text"
>            ] (
>            ScalarType "tsquery" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_tsvector"
>            [ ScalarType "text"
>            ] (
>            ScalarType "tsvector" )
>            False
>        , EnvCreateFunction
>            FunName
>            "to_tsvector"
>            [ ScalarType "regconfig"
>            , ScalarType "text"
>            ] (
>            ScalarType "tsvector" )
>            False
>        , EnvCreateFunction
>            FunName
>            "transaction_timestamp"
>            [] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunName
>            "translate"
>            [ ScalarType "text"
>            , ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "trigger_in"
>            [ Pseudo Cstring
>            ] (
>            Pseudo Trigger )
>            False
>        , EnvCreateFunction
>            FunName
>            "trigger_out"
>            [ Pseudo Trigger
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "trunc"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "trunc"
>            [ ScalarType "macaddr"
>            ] (
>            ScalarType "macaddr" )
>            False
>        , EnvCreateFunction
>            FunName
>            "trunc"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "trunc"
>            [ ScalarType "numeric"
>            , ScalarType "int4"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_debug"
>            [ ScalarType "text"
>            ] (
>            SetOfType ( Pseudo Record ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_debug"
>            [ ScalarType "regconfig"
>            , ScalarType "text"
>            ] (
>            SetOfType ( Pseudo Record ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_headline"
>            [ ScalarType "text"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_headline"
>            [ ScalarType "text"
>            , ScalarType "tsquery"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_headline"
>            [ ScalarType "regconfig"
>            , ScalarType "text"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_headline"
>            [ ScalarType "regconfig"
>            , ScalarType "text"
>            , ScalarType "tsquery"
>            , ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_lexize"
>            [ ScalarType "regdictionary"
>            , ScalarType "text"
>            ] (
>            ArrayType ( ScalarType "text" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_match_qv"
>            [ ScalarType "tsquery"
>            , ScalarType "tsvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_match_tq"
>            [ ScalarType "text"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_match_tt"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_match_vq"
>            [ ScalarType "tsvector"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_parse"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            SetOfType ( Pseudo Record ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_parse"
>            [ ScalarType "oid"
>            , ScalarType "text"
>            ] (
>            SetOfType ( Pseudo Record ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_rank"
>            [ ScalarType "tsvector"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_rank"
>            [ ArrayType ( ScalarType "float4" )
>            , ScalarType "tsvector"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_rank"
>            [ ScalarType "tsvector"
>            , ScalarType "tsquery"
>            , ScalarType "int4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_rank"
>            [ ArrayType ( ScalarType "float4" )
>            , ScalarType "tsvector"
>            , ScalarType "tsquery"
>            , ScalarType "int4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_rank_cd"
>            [ ScalarType "tsvector"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_rank_cd"
>            [ ArrayType ( ScalarType "float4" )
>            , ScalarType "tsvector"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_rank_cd"
>            [ ScalarType "tsvector"
>            , ScalarType "tsquery"
>            , ScalarType "int4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_rank_cd"
>            [ ArrayType ( ScalarType "float4" )
>            , ScalarType "tsvector"
>            , ScalarType "tsquery"
>            , ScalarType "int4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_rewrite"
>            [ ScalarType "tsquery"
>            , ScalarType "text"
>            ] (
>            ScalarType "tsquery" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_rewrite"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "tsquery" )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_stat"
>            [ ScalarType "text"
>            ] (
>            SetOfType ( Pseudo Record ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_stat"
>            [ ScalarType "text"
>            , ScalarType "text"
>            ] (
>            SetOfType ( Pseudo Record ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_token_type"
>            [ ScalarType "text"
>            ] (
>            SetOfType ( Pseudo Record ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_token_type"
>            [ ScalarType "oid"
>            ] (
>            SetOfType ( Pseudo Record ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "ts_typanalyze"
>            [ Pseudo Internal
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsmatchjoinsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int2"
>            , Pseudo Internal
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsmatchsel"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsq_mcontained"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsq_mcontains"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsquery_and"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "tsquery" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsquery_cmp"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsquery_eq"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsquery_ge"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsquery_gt"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsquery_le"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsquery_lt"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsquery_ne"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsquery_not"
>            [ ScalarType "tsquery"
>            ] (
>            ScalarType "tsquery" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsquery_or"
>            [ ScalarType "tsquery"
>            , ScalarType "tsquery"
>            ] (
>            ScalarType "tsquery" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsqueryin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "tsquery" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsqueryout"
>            [ ScalarType "tsquery"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsqueryrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "tsquery" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsquerysend"
>            [ ScalarType "tsquery"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsvector_cmp"
>            [ ScalarType "tsvector"
>            , ScalarType "tsvector"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsvector_concat"
>            [ ScalarType "tsvector"
>            , ScalarType "tsvector"
>            ] (
>            ScalarType "tsvector" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsvector_eq"
>            [ ScalarType "tsvector"
>            , ScalarType "tsvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsvector_ge"
>            [ ScalarType "tsvector"
>            , ScalarType "tsvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsvector_gt"
>            [ ScalarType "tsvector"
>            , ScalarType "tsvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsvector_le"
>            [ ScalarType "tsvector"
>            , ScalarType "tsvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsvector_lt"
>            [ ScalarType "tsvector"
>            , ScalarType "tsvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsvector_ne"
>            [ ScalarType "tsvector"
>            , ScalarType "tsvector"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsvector_update_trigger"
>            [] (
>            Pseudo Trigger )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsvector_update_trigger_column"
>            [] (
>            Pseudo Trigger )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsvectorin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "tsvector" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsvectorout"
>            [ ScalarType "tsvector"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsvectorrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "tsvector" )
>            False
>        , EnvCreateFunction
>            FunName
>            "tsvectorsend"
>            [ ScalarType "tsvector"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "txid_current"
>            [] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "txid_current_snapshot"
>            [] (
>            ScalarType "txid_snapshot" )
>            False
>        , EnvCreateFunction
>            FunName
>            "txid_snapshot_in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "txid_snapshot" )
>            False
>        , EnvCreateFunction
>            FunName
>            "txid_snapshot_out"
>            [ ScalarType "txid_snapshot"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "txid_snapshot_recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "txid_snapshot" )
>            False
>        , EnvCreateFunction
>            FunName
>            "txid_snapshot_send"
>            [ ScalarType "txid_snapshot"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "txid_snapshot_xip"
>            [ ScalarType "txid_snapshot"
>            ] (
>            SetOfType ( ScalarType "int8" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "txid_snapshot_xmax"
>            [ ScalarType "txid_snapshot"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "txid_snapshot_xmin"
>            [ ScalarType "txid_snapshot"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "txid_visible_in_snapshot"
>            [ ScalarType "int8"
>            , ScalarType "txid_snapshot"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "uhc_to_utf8"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "unknownin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "unknown" )
>            False
>        , EnvCreateFunction
>            FunName
>            "unknownout"
>            [ ScalarType "unknown"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "unknownrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "unknown" )
>            False
>        , EnvCreateFunction
>            FunName
>            "unknownsend"
>            [ ScalarType "unknown"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "unnest"
>            [ Pseudo AnyArray
>            ] (
>            SetOfType ( Pseudo AnyElement ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "upper"
>            [ ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "utf8_to_ascii"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "utf8_to_big5"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "utf8_to_euc_cn"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "utf8_to_euc_jis_2004"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "utf8_to_euc_jp"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "utf8_to_euc_kr"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "utf8_to_euc_tw"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "utf8_to_gb18030"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "utf8_to_gbk"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "utf8_to_iso8859"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "utf8_to_iso8859_1"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "utf8_to_johab"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "utf8_to_koi8r"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "utf8_to_koi8u"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "utf8_to_shift_jis_2004"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "utf8_to_sjis"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "utf8_to_uhc"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "utf8_to_win"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "uuid_cmp"
>            [ ScalarType "uuid"
>            , ScalarType "uuid"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "uuid_eq"
>            [ ScalarType "uuid"
>            , ScalarType "uuid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "uuid_ge"
>            [ ScalarType "uuid"
>            , ScalarType "uuid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "uuid_gt"
>            [ ScalarType "uuid"
>            , ScalarType "uuid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "uuid_hash"
>            [ ScalarType "uuid"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "uuid_in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "uuid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "uuid_le"
>            [ ScalarType "uuid"
>            , ScalarType "uuid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "uuid_lt"
>            [ ScalarType "uuid"
>            , ScalarType "uuid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "uuid_ne"
>            [ ScalarType "uuid"
>            , ScalarType "uuid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "uuid_out"
>            [ ScalarType "uuid"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "uuid_recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "uuid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "uuid_send"
>            [ ScalarType "uuid"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varbit"
>            [ ScalarType "varbit"
>            , ScalarType "int4"
>            , ScalarType "bool"
>            ] (
>            ScalarType "varbit" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varbit_in"
>            [ Pseudo Cstring
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "varbit" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varbit_out"
>            [ ScalarType "varbit"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "varbit_recv"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "varbit" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varbit_send"
>            [ ScalarType "varbit"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varbitcmp"
>            [ ScalarType "varbit"
>            , ScalarType "varbit"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varbiteq"
>            [ ScalarType "varbit"
>            , ScalarType "varbit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varbitge"
>            [ ScalarType "varbit"
>            , ScalarType "varbit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varbitgt"
>            [ ScalarType "varbit"
>            , ScalarType "varbit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varbitle"
>            [ ScalarType "varbit"
>            , ScalarType "varbit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varbitlt"
>            [ ScalarType "varbit"
>            , ScalarType "varbit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varbitne"
>            [ ScalarType "varbit"
>            , ScalarType "varbit"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varbittypmodin"
>            [ ArrayType ( Pseudo Cstring )
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varbittypmodout"
>            [ ScalarType "int4"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "varchar"
>            [ ScalarType "name"
>            ] (
>            ScalarType "varchar" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varchar"
>            [ ScalarType "varchar"
>            , ScalarType "int4"
>            , ScalarType "bool"
>            ] (
>            ScalarType "varchar" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varcharin"
>            [ Pseudo Cstring
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "varchar" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varcharout"
>            [ ScalarType "varchar"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "varcharrecv"
>            [ Pseudo Internal
>            , ScalarType "oid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "varchar" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varcharsend"
>            [ ScalarType "varchar"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varchartypmodin"
>            [ ArrayType ( Pseudo Cstring )
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "varchartypmodout"
>            [ ScalarType "int4"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "version"
>            [] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunName
>            "void_in"
>            [ Pseudo Cstring
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "void_out"
>            [ Pseudo Void
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "width"
>            [ ScalarType "box"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunName
>            "width_bucket"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            , ScalarType "float8"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "width_bucket"
>            [ ScalarType "numeric"
>            , ScalarType "numeric"
>            , ScalarType "numeric"
>            , ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunName
>            "win1250_to_latin2"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "win1250_to_mic"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "win1251_to_iso"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "win1251_to_koi8r"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "win1251_to_mic"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "win1251_to_win866"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "win866_to_iso"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "win866_to_koi8r"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "win866_to_mic"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "win866_to_win1251"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "win_to_utf8"
>            [ ScalarType "int4"
>            , ScalarType "int4"
>            , Pseudo Cstring
>            , Pseudo Internal
>            , ScalarType "int4"
>            ] (
>            Pseudo Void )
>            False
>        , EnvCreateFunction
>            FunName
>            "xideq"
>            [ ScalarType "xid"
>            , ScalarType "xid"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "xideqint4"
>            [ ScalarType "xid"
>            , ScalarType "int4"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "xidin"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "xid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "xidout"
>            [ ScalarType "xid"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "xidrecv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "xid" )
>            False
>        , EnvCreateFunction
>            FunName
>            "xidsend"
>            [ ScalarType "xid"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "xml"
>            [ ScalarType "text"
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "xml_in"
>            [ Pseudo Cstring
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "xml_out"
>            [ ScalarType "xml"
>            ] (
>            Pseudo Cstring )
>            False
>        , EnvCreateFunction
>            FunName
>            "xml_recv"
>            [ Pseudo Internal
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "xml_send"
>            [ ScalarType "xml"
>            ] (
>            ScalarType "bytea" )
>            False
>        , EnvCreateFunction
>            FunName
>            "xmlcomment"
>            [ ScalarType "text"
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "xmlconcat2"
>            [ ScalarType "xml"
>            , ScalarType "xml"
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunName
>            "xmlvalidate"
>            [ ScalarType "xml"
>            , ScalarType "text"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunName
>            "xpath"
>            [ ScalarType "text"
>            , ScalarType "xml"
>            ] (
>            ArrayType ( ScalarType "xml" ) )
>            False
>        , EnvCreateFunction
>            FunName
>            "xpath"
>            [ ScalarType "text"
>            , ScalarType "xml"
>            , ArrayType ( ScalarType "text" )
>            ] (
>            ArrayType ( ScalarType "xml" ) )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "array_agg"
>            [ Pseudo AnyElement
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "avg"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "avg"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "avg"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "avg"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "avg"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "avg"
>            [ ScalarType "interval"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "avg"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "bit_and"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "bit_and"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "bit_and"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "bit_and"
>            [ ScalarType "bit"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "bit_or"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "bit_or"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "bit_or"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "bit_or"
>            [ ScalarType "bit"
>            ] (
>            ScalarType "bit" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "bool_and"
>            [ ScalarType "bool"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "bool_or"
>            [ ScalarType "bool"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "corr"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "count"
>            [] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "count"
>            [ Pseudo Any
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "covar_pop"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "covar_samp"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "every"
>            [ ScalarType "bool"
>            ] (
>            ScalarType "bool" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "oid" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ ScalarType "tid"
>            ] (
>            ScalarType "tid" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ ScalarType "abstime"
>            ] (
>            ScalarType "abstime" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ ScalarType "money"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ ScalarType "bpchar"
>            ] (
>            ScalarType "bpchar" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ ScalarType "date"
>            ] (
>            ScalarType "date" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ ScalarType "time"
>            ] (
>            ScalarType "time" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ ScalarType "timestamp"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ ScalarType "timestamptz"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ ScalarType "interval"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ ScalarType "timetz"
>            ] (
>            ScalarType "timetz" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ Pseudo AnyArray
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "max"
>            [ Pseudo AnyEnum
>            ] (
>            Pseudo AnyEnum )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "int2" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ ScalarType "text"
>            ] (
>            ScalarType "text" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ ScalarType "oid"
>            ] (
>            ScalarType "oid" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ ScalarType "tid"
>            ] (
>            ScalarType "tid" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ ScalarType "abstime"
>            ] (
>            ScalarType "abstime" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ ScalarType "money"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ ScalarType "bpchar"
>            ] (
>            ScalarType "bpchar" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ ScalarType "date"
>            ] (
>            ScalarType "date" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ ScalarType "time"
>            ] (
>            ScalarType "time" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ ScalarType "timestamp"
>            ] (
>            ScalarType "timestamp" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ ScalarType "timestamptz"
>            ] (
>            ScalarType "timestamptz" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ ScalarType "interval"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ ScalarType "timetz"
>            ] (
>            ScalarType "timetz" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ Pseudo AnyArray
>            ] (
>            Pseudo AnyArray )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "min"
>            [ Pseudo AnyEnum
>            ] (
>            Pseudo AnyEnum )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "regr_avgx"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "regr_avgy"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "regr_count"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "regr_intercept"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "regr_r2"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "regr_slope"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "regr_sxx"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "regr_sxy"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "regr_syy"
>            [ ScalarType "float8"
>            , ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "stddev"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "stddev"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "stddev"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "stddev"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "stddev"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "stddev"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "stddev_pop"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "stddev_pop"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "stddev_pop"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "stddev_pop"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "stddev_pop"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "stddev_pop"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "stddev_samp"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "stddev_samp"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "stddev_samp"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "stddev_samp"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "stddev_samp"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "stddev_samp"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "sum"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "sum"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "sum"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "sum"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "float4" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "sum"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "sum"
>            [ ScalarType "money"
>            ] (
>            ScalarType "money" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "sum"
>            [ ScalarType "interval"
>            ] (
>            ScalarType "interval" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "sum"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "var_pop"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "var_pop"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "var_pop"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "var_pop"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "var_pop"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "var_pop"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "var_samp"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "var_samp"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "var_samp"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "var_samp"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "var_samp"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "var_samp"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "variance"
>            [ ScalarType "int8"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "variance"
>            [ ScalarType "int2"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "variance"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "variance"
>            [ ScalarType "float4"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "variance"
>            [ ScalarType "float8"
>            ] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "variance"
>            [ ScalarType "numeric"
>            ] (
>            ScalarType "numeric" )
>            False
>        , EnvCreateFunction
>            FunAgg
>            "xmlagg"
>            [ ScalarType "xml"
>            ] (
>            ScalarType "xml" )
>            False
>        , EnvCreateFunction
>            FunWindow
>            "cume_dist"
>            [] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunWindow
>            "dense_rank"
>            [] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunWindow
>            "first_value"
>            [ Pseudo AnyElement
>            ] (
>            Pseudo AnyElement )
>            False
>        , EnvCreateFunction
>            FunWindow
>            "lag"
>            [ Pseudo AnyElement
>            ] (
>            Pseudo AnyElement )
>            False
>        , EnvCreateFunction
>            FunWindow
>            "lag"
>            [ Pseudo AnyElement
>            , ScalarType "int4"
>            ] (
>            Pseudo AnyElement )
>            False
>        , EnvCreateFunction
>            FunWindow
>            "lag"
>            [ Pseudo AnyElement
>            , ScalarType "int4"
>            , Pseudo AnyElement
>            ] (
>            Pseudo AnyElement )
>            False
>        , EnvCreateFunction
>            FunWindow
>            "last_value"
>            [ Pseudo AnyElement
>            ] (
>            Pseudo AnyElement )
>            False
>        , EnvCreateFunction
>            FunWindow
>            "lead"
>            [ Pseudo AnyElement
>            ] (
>            Pseudo AnyElement )
>            False
>        , EnvCreateFunction
>            FunWindow
>            "lead"
>            [ Pseudo AnyElement
>            , ScalarType "int4"
>            ] (
>            Pseudo AnyElement )
>            False
>        , EnvCreateFunction
>            FunWindow
>            "lead"
>            [ Pseudo AnyElement
>            , ScalarType "int4"
>            , Pseudo AnyElement
>            ] (
>            Pseudo AnyElement )
>            False
>        , EnvCreateFunction
>            FunWindow
>            "nth_value"
>            [ Pseudo AnyElement
>            , ScalarType "int4"
>            ] (
>            Pseudo AnyElement )
>            False
>        , EnvCreateFunction
>            FunWindow
>            "ntile"
>            [ ScalarType "int4"
>            ] (
>            ScalarType "int4" )
>            False
>        , EnvCreateFunction
>            FunWindow
>            "percent_rank"
>            [] (
>            ScalarType "float8" )
>            False
>        , EnvCreateFunction
>            FunWindow
>            "rank"
>            [] (
>            ScalarType "int8" )
>            False
>        , EnvCreateFunction
>            FunWindow
>            "row_number"
>            [] (
>            ScalarType "int8" )
>            False
>        , EnvCreateTable
>            "pg_aggregate"
>            [ ( "aggfnoid"
>              , ScalarType "regproc"
>              )
>            , ( "aggtransfn"
>              , ScalarType "regproc"
>              )
>            , ( "aggfinalfn"
>              , ScalarType "regproc"
>              )
>            , ( "aggsortop"
>              , ScalarType "oid"
>              )
>            , ( "aggtranstype"
>              , ScalarType "oid"
>              )
>            , ( "agginitval"
>              , ScalarType "text"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_am"
>            [ ( "amname"
>              , ScalarType "name"
>              )
>            , ( "amstrategies"
>              , ScalarType "int2"
>              )
>            , ( "amsupport"
>              , ScalarType "int2"
>              )
>            , ( "amcanorder"
>              , ScalarType "bool"
>              )
>            , ( "amcanbackward"
>              , ScalarType "bool"
>              )
>            , ( "amcanunique"
>              , ScalarType "bool"
>              )
>            , ( "amcanmulticol"
>              , ScalarType "bool"
>              )
>            , ( "amoptionalkey"
>              , ScalarType "bool"
>              )
>            , ( "amindexnulls"
>              , ScalarType "bool"
>              )
>            , ( "amsearchnulls"
>              , ScalarType "bool"
>              )
>            , ( "amstorage"
>              , ScalarType "bool"
>              )
>            , ( "amclusterable"
>              , ScalarType "bool"
>              )
>            , ( "amkeytype"
>              , ScalarType "oid"
>              )
>            , ( "aminsert"
>              , ScalarType "regproc"
>              )
>            , ( "ambeginscan"
>              , ScalarType "regproc"
>              )
>            , ( "amgettuple"
>              , ScalarType "regproc"
>              )
>            , ( "amgetbitmap"
>              , ScalarType "regproc"
>              )
>            , ( "amrescan"
>              , ScalarType "regproc"
>              )
>            , ( "amendscan"
>              , ScalarType "regproc"
>              )
>            , ( "ammarkpos"
>              , ScalarType "regproc"
>              )
>            , ( "amrestrpos"
>              , ScalarType "regproc"
>              )
>            , ( "ambuild"
>              , ScalarType "regproc"
>              )
>            , ( "ambulkdelete"
>              , ScalarType "regproc"
>              )
>            , ( "amvacuumcleanup"
>              , ScalarType "regproc"
>              )
>            , ( "amcostestimate"
>              , ScalarType "regproc"
>              )
>            , ( "amoptions"
>              , ScalarType "regproc"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_amop"
>            [ ( "amopfamily"
>              , ScalarType "oid"
>              )
>            , ( "amoplefttype"
>              , ScalarType "oid"
>              )
>            , ( "amoprighttype"
>              , ScalarType "oid"
>              )
>            , ( "amopstrategy"
>              , ScalarType "int2"
>              )
>            , ( "amopopr"
>              , ScalarType "oid"
>              )
>            , ( "amopmethod"
>              , ScalarType "oid"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_amproc"
>            [ ( "amprocfamily"
>              , ScalarType "oid"
>              )
>            , ( "amproclefttype"
>              , ScalarType "oid"
>              )
>            , ( "amprocrighttype"
>              , ScalarType "oid"
>              )
>            , ( "amprocnum"
>              , ScalarType "int2"
>              )
>            , ( "amproc"
>              , ScalarType "regproc"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_attrdef"
>            [ ( "adrelid"
>              , ScalarType "oid"
>              )
>            , ( "adnum"
>              , ScalarType "int2"
>              )
>            , ( "adbin"
>              , ScalarType "text"
>              )
>            , ( "adsrc"
>              , ScalarType "text"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_attribute"
>            [ ( "attrelid"
>              , ScalarType "oid"
>              )
>            , ( "attname"
>              , ScalarType "name"
>              )
>            , ( "atttypid"
>              , ScalarType "oid"
>              )
>            , ( "attstattarget"
>              , ScalarType "int4"
>              )
>            , ( "attlen"
>              , ScalarType "int2"
>              )
>            , ( "attnum"
>              , ScalarType "int2"
>              )
>            , ( "attndims"
>              , ScalarType "int4"
>              )
>            , ( "attcacheoff"
>              , ScalarType "int4"
>              )
>            , ( "atttypmod"
>              , ScalarType "int4"
>              )
>            , ( "attbyval"
>              , ScalarType "bool"
>              )
>            , ( "attstorage"
>              , ScalarType "char"
>              )
>            , ( "attalign"
>              , ScalarType "char"
>              )
>            , ( "attnotnull"
>              , ScalarType "bool"
>              )
>            , ( "atthasdef"
>              , ScalarType "bool"
>              )
>            , ( "attisdropped"
>              , ScalarType "bool"
>              )
>            , ( "attislocal"
>              , ScalarType "bool"
>              )
>            , ( "attinhcount"
>              , ScalarType "int4"
>              )
>            , ( "attacl"
>              , ArrayType ( ScalarType "aclitem" )
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_auth_members"
>            [ ( "roleid"
>              , ScalarType "oid"
>              )
>            , ( "member"
>              , ScalarType "oid"
>              )
>            , ( "grantor"
>              , ScalarType "oid"
>              )
>            , ( "admin_option"
>              , ScalarType "bool"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_authid"
>            [ ( "rolname"
>              , ScalarType "name"
>              )
>            , ( "rolsuper"
>              , ScalarType "bool"
>              )
>            , ( "rolinherit"
>              , ScalarType "bool"
>              )
>            , ( "rolcreaterole"
>              , ScalarType "bool"
>              )
>            , ( "rolcreatedb"
>              , ScalarType "bool"
>              )
>            , ( "rolcatupdate"
>              , ScalarType "bool"
>              )
>            , ( "rolcanlogin"
>              , ScalarType "bool"
>              )
>            , ( "rolconnlimit"
>              , ScalarType "int4"
>              )
>            , ( "rolpassword"
>              , ScalarType "text"
>              )
>            , ( "rolvaliduntil"
>              , ScalarType "timestamptz"
>              )
>            , ( "rolconfig"
>              , ArrayType ( ScalarType "text" )
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_cast"
>            [ ( "castsource"
>              , ScalarType "oid"
>              )
>            , ( "casttarget"
>              , ScalarType "oid"
>              )
>            , ( "castfunc"
>              , ScalarType "oid"
>              )
>            , ( "castcontext"
>              , ScalarType "char"
>              )
>            , ( "castmethod"
>              , ScalarType "char"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_class"
>            [ ( "relname"
>              , ScalarType "name"
>              )
>            , ( "relnamespace"
>              , ScalarType "oid"
>              )
>            , ( "reltype"
>              , ScalarType "oid"
>              )
>            , ( "relowner"
>              , ScalarType "oid"
>              )
>            , ( "relam"
>              , ScalarType "oid"
>              )
>            , ( "relfilenode"
>              , ScalarType "oid"
>              )
>            , ( "reltablespace"
>              , ScalarType "oid"
>              )
>            , ( "relpages"
>              , ScalarType "int4"
>              )
>            , ( "reltuples"
>              , ScalarType "float4"
>              )
>            , ( "reltoastrelid"
>              , ScalarType "oid"
>              )
>            , ( "reltoastidxid"
>              , ScalarType "oid"
>              )
>            , ( "relhasindex"
>              , ScalarType "bool"
>              )
>            , ( "relisshared"
>              , ScalarType "bool"
>              )
>            , ( "relistemp"
>              , ScalarType "bool"
>              )
>            , ( "relkind"
>              , ScalarType "char"
>              )
>            , ( "relnatts"
>              , ScalarType "int2"
>              )
>            , ( "relchecks"
>              , ScalarType "int2"
>              )
>            , ( "relhasoids"
>              , ScalarType "bool"
>              )
>            , ( "relhaspkey"
>              , ScalarType "bool"
>              )
>            , ( "relhasrules"
>              , ScalarType "bool"
>              )
>            , ( "relhastriggers"
>              , ScalarType "bool"
>              )
>            , ( "relhassubclass"
>              , ScalarType "bool"
>              )
>            , ( "relfrozenxid"
>              , ScalarType "xid"
>              )
>            , ( "relacl"
>              , ArrayType ( ScalarType "aclitem" )
>              )
>            , ( "reloptions"
>              , ArrayType ( ScalarType "text" )
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_constraint"
>            [ ( "conname"
>              , ScalarType "name"
>              )
>            , ( "connamespace"
>              , ScalarType "oid"
>              )
>            , ( "contype"
>              , ScalarType "char"
>              )
>            , ( "condeferrable"
>              , ScalarType "bool"
>              )
>            , ( "condeferred"
>              , ScalarType "bool"
>              )
>            , ( "conrelid"
>              , ScalarType "oid"
>              )
>            , ( "contypid"
>              , ScalarType "oid"
>              )
>            , ( "confrelid"
>              , ScalarType "oid"
>              )
>            , ( "confupdtype"
>              , ScalarType "char"
>              )
>            , ( "confdeltype"
>              , ScalarType "char"
>              )
>            , ( "confmatchtype"
>              , ScalarType "char"
>              )
>            , ( "conislocal"
>              , ScalarType "bool"
>              )
>            , ( "coninhcount"
>              , ScalarType "int4"
>              )
>            , ( "conkey"
>              , ArrayType ( ScalarType "int2" )
>              )
>            , ( "confkey"
>              , ArrayType ( ScalarType "int2" )
>              )
>            , ( "conpfeqop"
>              , ArrayType ( ScalarType "oid" )
>              )
>            , ( "conppeqop"
>              , ArrayType ( ScalarType "oid" )
>              )
>            , ( "conffeqop"
>              , ArrayType ( ScalarType "oid" )
>              )
>            , ( "conbin"
>              , ScalarType "text"
>              )
>            , ( "consrc"
>              , ScalarType "text"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_conversion"
>            [ ( "conname"
>              , ScalarType "name"
>              )
>            , ( "connamespace"
>              , ScalarType "oid"
>              )
>            , ( "conowner"
>              , ScalarType "oid"
>              )
>            , ( "conforencoding"
>              , ScalarType "int4"
>              )
>            , ( "contoencoding"
>              , ScalarType "int4"
>              )
>            , ( "conproc"
>              , ScalarType "regproc"
>              )
>            , ( "condefault"
>              , ScalarType "bool"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_database"
>            [ ( "datname"
>              , ScalarType "name"
>              )
>            , ( "datdba"
>              , ScalarType "oid"
>              )
>            , ( "encoding"
>              , ScalarType "int4"
>              )
>            , ( "datcollate"
>              , ScalarType "name"
>              )
>            , ( "datctype"
>              , ScalarType "name"
>              )
>            , ( "datistemplate"
>              , ScalarType "bool"
>              )
>            , ( "datallowconn"
>              , ScalarType "bool"
>              )
>            , ( "datconnlimit"
>              , ScalarType "int4"
>              )
>            , ( "datlastsysoid"
>              , ScalarType "oid"
>              )
>            , ( "datfrozenxid"
>              , ScalarType "xid"
>              )
>            , ( "dattablespace"
>              , ScalarType "oid"
>              )
>            , ( "datconfig"
>              , ArrayType ( ScalarType "text" )
>              )
>            , ( "datacl"
>              , ArrayType ( ScalarType "aclitem" )
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_depend"
>            [ ( "classid"
>              , ScalarType "oid"
>              )
>            , ( "objid"
>              , ScalarType "oid"
>              )
>            , ( "objsubid"
>              , ScalarType "int4"
>              )
>            , ( "refclassid"
>              , ScalarType "oid"
>              )
>            , ( "refobjid"
>              , ScalarType "oid"
>              )
>            , ( "refobjsubid"
>              , ScalarType "int4"
>              )
>            , ( "deptype"
>              , ScalarType "char"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_description"
>            [ ( "objoid"
>              , ScalarType "oid"
>              )
>            , ( "classoid"
>              , ScalarType "oid"
>              )
>            , ( "objsubid"
>              , ScalarType "int4"
>              )
>            , ( "description"
>              , ScalarType "text"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_enum"
>            [ ( "enumtypid"
>              , ScalarType "oid"
>              )
>            , ( "enumlabel"
>              , ScalarType "name"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_foreign_data_wrapper"
>            [ ( "fdwname"
>              , ScalarType "name"
>              )
>            , ( "fdwowner"
>              , ScalarType "oid"
>              )
>            , ( "fdwvalidator"
>              , ScalarType "oid"
>              )
>            , ( "fdwacl"
>              , ArrayType ( ScalarType "aclitem" )
>              )
>            , ( "fdwoptions"
>              , ArrayType ( ScalarType "text" )
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_foreign_server"
>            [ ( "srvname"
>              , ScalarType "name"
>              )
>            , ( "srvowner"
>              , ScalarType "oid"
>              )
>            , ( "srvfdw"
>              , ScalarType "oid"
>              )
>            , ( "srvtype"
>              , ScalarType "text"
>              )
>            , ( "srvversion"
>              , ScalarType "text"
>              )
>            , ( "srvacl"
>              , ArrayType ( ScalarType "aclitem" )
>              )
>            , ( "srvoptions"
>              , ArrayType ( ScalarType "text" )
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_index"
>            [ ( "indexrelid"
>              , ScalarType "oid"
>              )
>            , ( "indrelid"
>              , ScalarType "oid"
>              )
>            , ( "indnatts"
>              , ScalarType "int2"
>              )
>            , ( "indisunique"
>              , ScalarType "bool"
>              )
>            , ( "indisprimary"
>              , ScalarType "bool"
>              )
>            , ( "indisclustered"
>              , ScalarType "bool"
>              )
>            , ( "indisvalid"
>              , ScalarType "bool"
>              )
>            , ( "indcheckxmin"
>              , ScalarType "bool"
>              )
>            , ( "indisready"
>              , ScalarType "bool"
>              )
>            , ( "indkey"
>              , ScalarType "int2vector"
>              )
>            , ( "indclass"
>              , ScalarType "oidvector"
>              )
>            , ( "indoption"
>              , ScalarType "int2vector"
>              )
>            , ( "indexprs"
>              , ScalarType "text"
>              )
>            , ( "indpred"
>              , ScalarType "text"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_inherits"
>            [ ( "inhrelid"
>              , ScalarType "oid"
>              )
>            , ( "inhparent"
>              , ScalarType "oid"
>              )
>            , ( "inhseqno"
>              , ScalarType "int4"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_language"
>            [ ( "lanname"
>              , ScalarType "name"
>              )
>            , ( "lanowner"
>              , ScalarType "oid"
>              )
>            , ( "lanispl"
>              , ScalarType "bool"
>              )
>            , ( "lanpltrusted"
>              , ScalarType "bool"
>              )
>            , ( "lanplcallfoid"
>              , ScalarType "oid"
>              )
>            , ( "lanvalidator"
>              , ScalarType "oid"
>              )
>            , ( "lanacl"
>              , ArrayType ( ScalarType "aclitem" )
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_largeobject"
>            [ ( "loid"
>              , ScalarType "oid"
>              )
>            , ( "pageno"
>              , ScalarType "int4"
>              )
>            , ( "data"
>              , ScalarType "bytea"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_listener"
>            [ ( "relname"
>              , ScalarType "name"
>              )
>            , ( "listenerpid"
>              , ScalarType "int4"
>              )
>            , ( "notification"
>              , ScalarType "int4"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_namespace"
>            [ ( "nspname"
>              , ScalarType "name"
>              )
>            , ( "nspowner"
>              , ScalarType "oid"
>              )
>            , ( "nspacl"
>              , ArrayType ( ScalarType "aclitem" )
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_opclass"
>            [ ( "opcmethod"
>              , ScalarType "oid"
>              )
>            , ( "opcname"
>              , ScalarType "name"
>              )
>            , ( "opcnamespace"
>              , ScalarType "oid"
>              )
>            , ( "opcowner"
>              , ScalarType "oid"
>              )
>            , ( "opcfamily"
>              , ScalarType "oid"
>              )
>            , ( "opcintype"
>              , ScalarType "oid"
>              )
>            , ( "opcdefault"
>              , ScalarType "bool"
>              )
>            , ( "opckeytype"
>              , ScalarType "oid"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_operator"
>            [ ( "oprname"
>              , ScalarType "name"
>              )
>            , ( "oprnamespace"
>              , ScalarType "oid"
>              )
>            , ( "oprowner"
>              , ScalarType "oid"
>              )
>            , ( "oprkind"
>              , ScalarType "char"
>              )
>            , ( "oprcanmerge"
>              , ScalarType "bool"
>              )
>            , ( "oprcanhash"
>              , ScalarType "bool"
>              )
>            , ( "oprleft"
>              , ScalarType "oid"
>              )
>            , ( "oprright"
>              , ScalarType "oid"
>              )
>            , ( "oprresult"
>              , ScalarType "oid"
>              )
>            , ( "oprcom"
>              , ScalarType "oid"
>              )
>            , ( "oprnegate"
>              , ScalarType "oid"
>              )
>            , ( "oprcode"
>              , ScalarType "regproc"
>              )
>            , ( "oprrest"
>              , ScalarType "regproc"
>              )
>            , ( "oprjoin"
>              , ScalarType "regproc"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_opfamily"
>            [ ( "opfmethod"
>              , ScalarType "oid"
>              )
>            , ( "opfname"
>              , ScalarType "name"
>              )
>            , ( "opfnamespace"
>              , ScalarType "oid"
>              )
>            , ( "opfowner"
>              , ScalarType "oid"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_pltemplate"
>            [ ( "tmplname"
>              , ScalarType "name"
>              )
>            , ( "tmpltrusted"
>              , ScalarType "bool"
>              )
>            , ( "tmpldbacreate"
>              , ScalarType "bool"
>              )
>            , ( "tmplhandler"
>              , ScalarType "text"
>              )
>            , ( "tmplvalidator"
>              , ScalarType "text"
>              )
>            , ( "tmpllibrary"
>              , ScalarType "text"
>              )
>            , ( "tmplacl"
>              , ArrayType ( ScalarType "aclitem" )
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_proc"
>            [ ( "proname"
>              , ScalarType "name"
>              )
>            , ( "pronamespace"
>              , ScalarType "oid"
>              )
>            , ( "proowner"
>              , ScalarType "oid"
>              )
>            , ( "prolang"
>              , ScalarType "oid"
>              )
>            , ( "procost"
>              , ScalarType "float4"
>              )
>            , ( "prorows"
>              , ScalarType "float4"
>              )
>            , ( "provariadic"
>              , ScalarType "oid"
>              )
>            , ( "proisagg"
>              , ScalarType "bool"
>              )
>            , ( "proiswindow"
>              , ScalarType "bool"
>              )
>            , ( "prosecdef"
>              , ScalarType "bool"
>              )
>            , ( "proisstrict"
>              , ScalarType "bool"
>              )
>            , ( "proretset"
>              , ScalarType "bool"
>              )
>            , ( "provolatile"
>              , ScalarType "char"
>              )
>            , ( "pronargs"
>              , ScalarType "int2"
>              )
>            , ( "pronargdefaults"
>              , ScalarType "int2"
>              )
>            , ( "prorettype"
>              , ScalarType "oid"
>              )
>            , ( "proargtypes"
>              , ScalarType "oidvector"
>              )
>            , ( "proallargtypes"
>              , ArrayType ( ScalarType "oid" )
>              )
>            , ( "proargmodes"
>              , ArrayType ( ScalarType "char" )
>              )
>            , ( "proargnames"
>              , ArrayType ( ScalarType "text" )
>              )
>            , ( "proargdefaults"
>              , ScalarType "text"
>              )
>            , ( "prosrc"
>              , ScalarType "text"
>              )
>            , ( "probin"
>              , ScalarType "bytea"
>              )
>            , ( "proconfig"
>              , ArrayType ( ScalarType "text" )
>              )
>            , ( "proacl"
>              , ArrayType ( ScalarType "aclitem" )
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_rewrite"
>            [ ( "rulename"
>              , ScalarType "name"
>              )
>            , ( "ev_class"
>              , ScalarType "oid"
>              )
>            , ( "ev_attr"
>              , ScalarType "int2"
>              )
>            , ( "ev_type"
>              , ScalarType "char"
>              )
>            , ( "ev_enabled"
>              , ScalarType "char"
>              )
>            , ( "is_instead"
>              , ScalarType "bool"
>              )
>            , ( "ev_qual"
>              , ScalarType "text"
>              )
>            , ( "ev_action"
>              , ScalarType "text"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_shdepend"
>            [ ( "dbid"
>              , ScalarType "oid"
>              )
>            , ( "classid"
>              , ScalarType "oid"
>              )
>            , ( "objid"
>              , ScalarType "oid"
>              )
>            , ( "objsubid"
>              , ScalarType "int4"
>              )
>            , ( "refclassid"
>              , ScalarType "oid"
>              )
>            , ( "refobjid"
>              , ScalarType "oid"
>              )
>            , ( "deptype"
>              , ScalarType "char"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_shdescription"
>            [ ( "objoid"
>              , ScalarType "oid"
>              )
>            , ( "classoid"
>              , ScalarType "oid"
>              )
>            , ( "description"
>              , ScalarType "text"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_statistic"
>            [ ( "starelid"
>              , ScalarType "oid"
>              )
>            , ( "staattnum"
>              , ScalarType "int2"
>              )
>            , ( "stanullfrac"
>              , ScalarType "float4"
>              )
>            , ( "stawidth"
>              , ScalarType "int4"
>              )
>            , ( "stadistinct"
>              , ScalarType "float4"
>              )
>            , ( "stakind1"
>              , ScalarType "int2"
>              )
>            , ( "stakind2"
>              , ScalarType "int2"
>              )
>            , ( "stakind3"
>              , ScalarType "int2"
>              )
>            , ( "stakind4"
>              , ScalarType "int2"
>              )
>            , ( "staop1"
>              , ScalarType "oid"
>              )
>            , ( "staop2"
>              , ScalarType "oid"
>              )
>            , ( "staop3"
>              , ScalarType "oid"
>              )
>            , ( "staop4"
>              , ScalarType "oid"
>              )
>            , ( "stanumbers1"
>              , ArrayType ( ScalarType "float4" )
>              )
>            , ( "stanumbers2"
>              , ArrayType ( ScalarType "float4" )
>              )
>            , ( "stanumbers3"
>              , ArrayType ( ScalarType "float4" )
>              )
>            , ( "stanumbers4"
>              , ArrayType ( ScalarType "float4" )
>              )
>            , ( "stavalues1"
>              , Pseudo AnyArray
>              )
>            , ( "stavalues2"
>              , Pseudo AnyArray
>              )
>            , ( "stavalues3"
>              , Pseudo AnyArray
>              )
>            , ( "stavalues4"
>              , Pseudo AnyArray
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_tablespace"
>            [ ( "spcname"
>              , ScalarType "name"
>              )
>            , ( "spcowner"
>              , ScalarType "oid"
>              )
>            , ( "spclocation"
>              , ScalarType "text"
>              )
>            , ( "spcacl"
>              , ArrayType ( ScalarType "aclitem" )
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_trigger"
>            [ ( "tgrelid"
>              , ScalarType "oid"
>              )
>            , ( "tgname"
>              , ScalarType "name"
>              )
>            , ( "tgfoid"
>              , ScalarType "oid"
>              )
>            , ( "tgtype"
>              , ScalarType "int2"
>              )
>            , ( "tgenabled"
>              , ScalarType "char"
>              )
>            , ( "tgisconstraint"
>              , ScalarType "bool"
>              )
>            , ( "tgconstrname"
>              , ScalarType "name"
>              )
>            , ( "tgconstrrelid"
>              , ScalarType "oid"
>              )
>            , ( "tgconstraint"
>              , ScalarType "oid"
>              )
>            , ( "tgdeferrable"
>              , ScalarType "bool"
>              )
>            , ( "tginitdeferred"
>              , ScalarType "bool"
>              )
>            , ( "tgnargs"
>              , ScalarType "int2"
>              )
>            , ( "tgattr"
>              , ScalarType "int2vector"
>              )
>            , ( "tgargs"
>              , ScalarType "bytea"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_ts_config"
>            [ ( "cfgname"
>              , ScalarType "name"
>              )
>            , ( "cfgnamespace"
>              , ScalarType "oid"
>              )
>            , ( "cfgowner"
>              , ScalarType "oid"
>              )
>            , ( "cfgparser"
>              , ScalarType "oid"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_ts_config_map"
>            [ ( "mapcfg"
>              , ScalarType "oid"
>              )
>            , ( "maptokentype"
>              , ScalarType "int4"
>              )
>            , ( "mapseqno"
>              , ScalarType "int4"
>              )
>            , ( "mapdict"
>              , ScalarType "oid"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_ts_dict"
>            [ ( "dictname"
>              , ScalarType "name"
>              )
>            , ( "dictnamespace"
>              , ScalarType "oid"
>              )
>            , ( "dictowner"
>              , ScalarType "oid"
>              )
>            , ( "dicttemplate"
>              , ScalarType "oid"
>              )
>            , ( "dictinitoption"
>              , ScalarType "text"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_ts_parser"
>            [ ( "prsname"
>              , ScalarType "name"
>              )
>            , ( "prsnamespace"
>              , ScalarType "oid"
>              )
>            , ( "prsstart"
>              , ScalarType "regproc"
>              )
>            , ( "prstoken"
>              , ScalarType "regproc"
>              )
>            , ( "prsend"
>              , ScalarType "regproc"
>              )
>            , ( "prsheadline"
>              , ScalarType "regproc"
>              )
>            , ( "prslextype"
>              , ScalarType "regproc"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_ts_template"
>            [ ( "tmplname"
>              , ScalarType "name"
>              )
>            , ( "tmplnamespace"
>              , ScalarType "oid"
>              )
>            , ( "tmplinit"
>              , ScalarType "regproc"
>              )
>            , ( "tmpllexize"
>              , ScalarType "regproc"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_type"
>            [ ( "typname"
>              , ScalarType "name"
>              )
>            , ( "typnamespace"
>              , ScalarType "oid"
>              )
>            , ( "typowner"
>              , ScalarType "oid"
>              )
>            , ( "typlen"
>              , ScalarType "int2"
>              )
>            , ( "typbyval"
>              , ScalarType "bool"
>              )
>            , ( "typtype"
>              , ScalarType "char"
>              )
>            , ( "typcategory"
>              , ScalarType "char"
>              )
>            , ( "typispreferred"
>              , ScalarType "bool"
>              )
>            , ( "typisdefined"
>              , ScalarType "bool"
>              )
>            , ( "typdelim"
>              , ScalarType "char"
>              )
>            , ( "typrelid"
>              , ScalarType "oid"
>              )
>            , ( "typelem"
>              , ScalarType "oid"
>              )
>            , ( "typarray"
>              , ScalarType "oid"
>              )
>            , ( "typinput"
>              , ScalarType "regproc"
>              )
>            , ( "typoutput"
>              , ScalarType "regproc"
>              )
>            , ( "typreceive"
>              , ScalarType "regproc"
>              )
>            , ( "typsend"
>              , ScalarType "regproc"
>              )
>            , ( "typmodin"
>              , ScalarType "regproc"
>              )
>            , ( "typmodout"
>              , ScalarType "regproc"
>              )
>            , ( "typanalyze"
>              , ScalarType "regproc"
>              )
>            , ( "typalign"
>              , ScalarType "char"
>              )
>            , ( "typstorage"
>              , ScalarType "char"
>              )
>            , ( "typnotnull"
>              , ScalarType "bool"
>              )
>            , ( "typbasetype"
>              , ScalarType "oid"
>              )
>            , ( "typtypmod"
>              , ScalarType "int4"
>              )
>            , ( "typndims"
>              , ScalarType "int4"
>              )
>            , ( "typdefaultbin"
>              , ScalarType "text"
>              )
>            , ( "typdefault"
>              , ScalarType "text"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "pg_user_mapping"
>            [ ( "umuser"
>              , ScalarType "oid"
>              )
>            , ( "umserver"
>              , ScalarType "oid"
>              )
>            , ( "umoptions"
>              , ArrayType ( ScalarType "text" )
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "information_schema.sql_features"
>            [ ( "feature_id"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "feature_name"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "sub_feature_id"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "sub_feature_name"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_supported"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_verified_by"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "comments"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "information_schema.sql_implementation_info"
>            [ ( "implementation_info_id"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "implementation_info_name"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "integer_value"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "character_value"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "comments"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "information_schema.sql_languages"
>            [ ( "sql_language_source"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "sql_language_year"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "sql_language_conformance"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "sql_language_integrity"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "sql_language_implementation"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "sql_language_binding_style"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "sql_language_programming_language"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "information_schema.sql_packages"
>            [ ( "feature_id"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "feature_name"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_supported"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_verified_by"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "comments"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "information_schema.sql_parts"
>            [ ( "feature_id"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "feature_name"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_supported"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_verified_by"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "comments"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "information_schema.sql_sizing"
>            [ ( "sizing_id"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "sizing_name"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "supported_value"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "comments"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateTable
>            "information_schema.sql_sizing_profiles"
>            [ ( "sizing_id"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "sizing_name"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "profile_id"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "required_value"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "comments"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>            [ ( "tableoid"
>              , ScalarType "oid"
>              )
>            , ( "cmax"
>              , ScalarType "cid"
>              )
>            , ( "xmax"
>              , ScalarType "xid"
>              )
>            , ( "cmin"
>              , ScalarType "cid"
>              )
>            , ( "xmin"
>              , ScalarType "xid"
>              )
>            , ( "ctid"
>              , ScalarType "tid"
>              )
>            ]
>        , EnvCreateView
>            "information_schema._pg_foreign_data_wrappers"
>            [ ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "fdwowner"
>              , ScalarType "oid"
>              )
>            , ( "fdwoptions"
>              , ArrayType ( ScalarType "text" )
>              )
>            , ( "foreign_data_wrapper_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_data_wrapper_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "authorization_identifier"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_data_wrapper_language"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema._pg_foreign_servers"
>            [ ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "srvoptions"
>              , ArrayType ( ScalarType "text" )
>              )
>            , ( "foreign_server_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_server_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_data_wrapper_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_data_wrapper_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_server_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "foreign_server_version"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "authorization_identifier"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema._pg_user_mappings"
>            [ ( "oid"
>              , ScalarType "oid"
>              )
>            , ( "umoptions"
>              , ArrayType ( ScalarType "text" )
>              )
>            , ( "umuser"
>              , ScalarType "oid"
>              )
>            , ( "authorization_identifier"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_server_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_server_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "srvowner"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.administrable_role_authorizations"
>            [ ( "grantee"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "role_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "is_grantable"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.applicable_roles"
>            [ ( "grantee"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "role_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "is_grantable"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.attributes"
>            [ ( "udt_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "udt_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "udt_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "attribute_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "ordinal_position"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "attribute_default"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_nullable"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "data_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "character_maximum_length"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "character_octet_length"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "character_set_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "character_set_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "character_set_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "collation_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "collation_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "collation_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "numeric_precision"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "numeric_precision_radix"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "numeric_scale"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "datetime_precision"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "interval_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "interval_precision"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "attribute_udt_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "attribute_udt_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "attribute_udt_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "scope_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "scope_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "scope_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "maximum_cardinality"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "dtd_identifier"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "is_derived_reference_attribute"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.check_constraint_routine_usage"
>            [ ( "constraint_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "specific_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "specific_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "specific_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.check_constraints"
>            [ ( "constraint_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "check_clause"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.column_domain_usage"
>            [ ( "domain_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "domain_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "domain_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "column_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.column_privileges"
>            [ ( "grantor"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "grantee"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "column_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "privilege_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_grantable"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.column_udt_usage"
>            [ ( "udt_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "udt_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "udt_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "column_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.columns"
>            [ ( "table_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "column_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "ordinal_position"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "column_default"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_nullable"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "data_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "character_maximum_length"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "character_octet_length"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "numeric_precision"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "numeric_precision_radix"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "numeric_scale"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "datetime_precision"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "interval_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "interval_precision"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "character_set_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "character_set_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "character_set_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "collation_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "collation_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "collation_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "domain_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "domain_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "domain_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "udt_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "udt_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "udt_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "scope_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "scope_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "scope_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "maximum_cardinality"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "dtd_identifier"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "is_self_referencing"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_identity"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "identity_generation"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "identity_start"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "identity_increment"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "identity_maximum"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "identity_minimum"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "identity_cycle"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_generated"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "generation_expression"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_updatable"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.constraint_column_usage"
>            [ ( "table_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "column_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.constraint_table_usage"
>            [ ( "table_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.data_type_privileges"
>            [ ( "object_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "object_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "object_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "object_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "dtd_identifier"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.domain_constraints"
>            [ ( "constraint_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "domain_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "domain_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "domain_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "is_deferrable"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "initially_deferred"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.domain_udt_usage"
>            [ ( "udt_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "udt_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "udt_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "domain_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "domain_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "domain_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.domains"
>            [ ( "domain_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "domain_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "domain_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "data_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "character_maximum_length"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "character_octet_length"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "character_set_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "character_set_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "character_set_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "collation_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "collation_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "collation_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "numeric_precision"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "numeric_precision_radix"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "numeric_scale"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "datetime_precision"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "interval_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "interval_precision"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "domain_default"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "udt_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "udt_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "udt_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "scope_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "scope_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "scope_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "maximum_cardinality"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "dtd_identifier"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.element_types"
>            [ ( "object_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "object_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "object_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "object_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "collection_type_identifier"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "data_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "character_maximum_length"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "character_octet_length"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "character_set_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "character_set_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "character_set_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "collation_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "collation_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "collation_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "numeric_precision"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "numeric_precision_radix"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "numeric_scale"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "datetime_precision"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "interval_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "interval_precision"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "domain_default"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "udt_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "udt_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "udt_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "scope_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "scope_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "scope_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "maximum_cardinality"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "dtd_identifier"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.enabled_roles"
>            [ ( "role_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.foreign_data_wrapper_options"
>            [ ( "foreign_data_wrapper_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_data_wrapper_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "option_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "option_value"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.foreign_data_wrappers"
>            [ ( "foreign_data_wrapper_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_data_wrapper_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "authorization_identifier"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "library_name"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "foreign_data_wrapper_language"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.foreign_server_options"
>            [ ( "foreign_server_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_server_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "option_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "option_value"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.foreign_servers"
>            [ ( "foreign_server_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_server_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_data_wrapper_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_data_wrapper_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_server_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "foreign_server_version"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "authorization_identifier"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.information_schema_catalog_name"
>            [ ( "catalog_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.key_column_usage"
>            [ ( "constraint_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "column_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "ordinal_position"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "position_in_unique_constraint"
>              , DomainType "information_schema.cardinal_number"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.parameters"
>            [ ( "specific_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "specific_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "specific_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "ordinal_position"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "parameter_mode"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_result"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "as_locator"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "parameter_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "data_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "character_maximum_length"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "character_octet_length"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "character_set_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "character_set_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "character_set_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "collation_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "collation_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "collation_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "numeric_precision"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "numeric_precision_radix"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "numeric_scale"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "datetime_precision"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "interval_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "interval_precision"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "udt_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "udt_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "udt_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "scope_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "scope_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "scope_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "maximum_cardinality"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "dtd_identifier"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "pg_cursors"
>            [ ( "name"
>              , ScalarType "text"
>              )
>            , ( "statement"
>              , ScalarType "text"
>              )
>            , ( "is_holdable"
>              , ScalarType "bool"
>              )
>            , ( "is_binary"
>              , ScalarType "bool"
>              )
>            , ( "is_scrollable"
>              , ScalarType "bool"
>              )
>            , ( "creation_time"
>              , ScalarType "timestamptz"
>              )
>            ]
>        , EnvCreateView
>            "pg_group"
>            [ ( "groname"
>              , ScalarType "name"
>              )
>            , ( "grosysid"
>              , ScalarType "oid"
>              )
>            , ( "grolist"
>              , ArrayType ( ScalarType "oid" )
>              )
>            ]
>        , EnvCreateView
>            "pg_indexes"
>            [ ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "tablename"
>              , ScalarType "name"
>              )
>            , ( "indexname"
>              , ScalarType "name"
>              )
>            , ( "tablespace"
>              , ScalarType "name"
>              )
>            , ( "indexdef"
>              , ScalarType "text"
>              )
>            ]
>        , EnvCreateView
>            "pg_locks"
>            [ ( "locktype"
>              , ScalarType "text"
>              )
>            , ( "database"
>              , ScalarType "oid"
>              )
>            , ( "relation"
>              , ScalarType "oid"
>              )
>            , ( "page"
>              , ScalarType "int4"
>              )
>            , ( "tuple"
>              , ScalarType "int2"
>              )
>            , ( "virtualxid"
>              , ScalarType "text"
>              )
>            , ( "transactionid"
>              , ScalarType "xid"
>              )
>            , ( "classid"
>              , ScalarType "oid"
>              )
>            , ( "objid"
>              , ScalarType "oid"
>              )
>            , ( "objsubid"
>              , ScalarType "int2"
>              )
>            , ( "virtualtransaction"
>              , ScalarType "text"
>              )
>            , ( "pid"
>              , ScalarType "int4"
>              )
>            , ( "mode"
>              , ScalarType "text"
>              )
>            , ( "granted"
>              , ScalarType "bool"
>              )
>            ]
>        , EnvCreateView
>            "pg_prepared_statements"
>            [ ( "name"
>              , ScalarType "text"
>              )
>            , ( "statement"
>              , ScalarType "text"
>              )
>            , ( "prepare_time"
>              , ScalarType "timestamptz"
>              )
>            , ( "parameter_types"
>              , ArrayType ( ScalarType "regtype" )
>              )
>            , ( "from_sql"
>              , ScalarType "bool"
>              )
>            ]
>        , EnvCreateView
>            "pg_prepared_xacts"
>            [ ( "transaction"
>              , ScalarType "xid"
>              )
>            , ( "gid"
>              , ScalarType "text"
>              )
>            , ( "prepared"
>              , ScalarType "timestamptz"
>              )
>            , ( "owner"
>              , ScalarType "name"
>              )
>            , ( "database"
>              , ScalarType "name"
>              )
>            ]
>        , EnvCreateView
>            "pg_roles"
>            [ ( "rolname"
>              , ScalarType "name"
>              )
>            , ( "rolsuper"
>              , ScalarType "bool"
>              )
>            , ( "rolinherit"
>              , ScalarType "bool"
>              )
>            , ( "rolcreaterole"
>              , ScalarType "bool"
>              )
>            , ( "rolcreatedb"
>              , ScalarType "bool"
>              )
>            , ( "rolcatupdate"
>              , ScalarType "bool"
>              )
>            , ( "rolcanlogin"
>              , ScalarType "bool"
>              )
>            , ( "rolconnlimit"
>              , ScalarType "int4"
>              )
>            , ( "rolpassword"
>              , ScalarType "text"
>              )
>            , ( "rolvaliduntil"
>              , ScalarType "timestamptz"
>              )
>            , ( "rolconfig"
>              , ArrayType ( ScalarType "text" )
>              )
>            , ( "oid"
>              , ScalarType "oid"
>              )
>            ]
>        , EnvCreateView
>            "pg_rules"
>            [ ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "tablename"
>              , ScalarType "name"
>              )
>            , ( "rulename"
>              , ScalarType "name"
>              )
>            , ( "definition"
>              , ScalarType "text"
>              )
>            ]
>        , EnvCreateView
>            "pg_settings"
>            [ ( "name"
>              , ScalarType "text"
>              )
>            , ( "setting"
>              , ScalarType "text"
>              )
>            , ( "unit"
>              , ScalarType "text"
>              )
>            , ( "category"
>              , ScalarType "text"
>              )
>            , ( "short_desc"
>              , ScalarType "text"
>              )
>            , ( "extra_desc"
>              , ScalarType "text"
>              )
>            , ( "context"
>              , ScalarType "text"
>              )
>            , ( "vartype"
>              , ScalarType "text"
>              )
>            , ( "source"
>              , ScalarType "text"
>              )
>            , ( "min_val"
>              , ScalarType "text"
>              )
>            , ( "max_val"
>              , ScalarType "text"
>              )
>            , ( "enumvals"
>              , ArrayType ( ScalarType "text" )
>              )
>            , ( "boot_val"
>              , ScalarType "text"
>              )
>            , ( "reset_val"
>              , ScalarType "text"
>              )
>            , ( "sourcefile"
>              , ScalarType "text"
>              )
>            , ( "sourceline"
>              , ScalarType "int4"
>              )
>            ]
>        , EnvCreateView
>            "pg_shadow"
>            [ ( "usename"
>              , ScalarType "name"
>              )
>            , ( "usesysid"
>              , ScalarType "oid"
>              )
>            , ( "usecreatedb"
>              , ScalarType "bool"
>              )
>            , ( "usesuper"
>              , ScalarType "bool"
>              )
>            , ( "usecatupd"
>              , ScalarType "bool"
>              )
>            , ( "passwd"
>              , ScalarType "text"
>              )
>            , ( "valuntil"
>              , ScalarType "abstime"
>              )
>            , ( "useconfig"
>              , ArrayType ( ScalarType "text" )
>              )
>            ]
>        , EnvCreateView
>            "pg_stat_activity"
>            [ ( "datid"
>              , ScalarType "oid"
>              )
>            , ( "datname"
>              , ScalarType "name"
>              )
>            , ( "procpid"
>              , ScalarType "int4"
>              )
>            , ( "usesysid"
>              , ScalarType "oid"
>              )
>            , ( "usename"
>              , ScalarType "name"
>              )
>            , ( "current_query"
>              , ScalarType "text"
>              )
>            , ( "waiting"
>              , ScalarType "bool"
>              )
>            , ( "xact_start"
>              , ScalarType "timestamptz"
>              )
>            , ( "query_start"
>              , ScalarType "timestamptz"
>              )
>            , ( "backend_start"
>              , ScalarType "timestamptz"
>              )
>            , ( "client_addr"
>              , ScalarType "inet"
>              )
>            , ( "client_port"
>              , ScalarType "int4"
>              )
>            ]
>        , EnvCreateView
>            "pg_stat_all_indexes"
>            [ ( "relid"
>              , ScalarType "oid"
>              )
>            , ( "indexrelid"
>              , ScalarType "oid"
>              )
>            , ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "relname"
>              , ScalarType "name"
>              )
>            , ( "indexrelname"
>              , ScalarType "name"
>              )
>            , ( "idx_scan"
>              , ScalarType "int8"
>              )
>            , ( "idx_tup_read"
>              , ScalarType "int8"
>              )
>            , ( "idx_tup_fetch"
>              , ScalarType "int8"
>              )
>            ]
>        , EnvCreateView
>            "pg_stat_all_tables"
>            [ ( "relid"
>              , ScalarType "oid"
>              )
>            , ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "relname"
>              , ScalarType "name"
>              )
>            , ( "seq_scan"
>              , ScalarType "int8"
>              )
>            , ( "seq_tup_read"
>              , ScalarType "int8"
>              )
>            , ( "idx_scan"
>              , ScalarType "int8"
>              )
>            , ( "idx_tup_fetch"
>              , ScalarType "int8"
>              )
>            , ( "n_tup_ins"
>              , ScalarType "int8"
>              )
>            , ( "n_tup_upd"
>              , ScalarType "int8"
>              )
>            , ( "n_tup_del"
>              , ScalarType "int8"
>              )
>            , ( "n_tup_hot_upd"
>              , ScalarType "int8"
>              )
>            , ( "n_live_tup"
>              , ScalarType "int8"
>              )
>            , ( "n_dead_tup"
>              , ScalarType "int8"
>              )
>            , ( "last_vacuum"
>              , ScalarType "timestamptz"
>              )
>            , ( "last_autovacuum"
>              , ScalarType "timestamptz"
>              )
>            , ( "last_analyze"
>              , ScalarType "timestamptz"
>              )
>            , ( "last_autoanalyze"
>              , ScalarType "timestamptz"
>              )
>            ]
>        , EnvCreateView
>            "pg_stat_bgwriter"
>            [ ( "checkpoints_timed"
>              , ScalarType "int8"
>              )
>            , ( "checkpoints_req"
>              , ScalarType "int8"
>              )
>            , ( "buffers_checkpoint"
>              , ScalarType "int8"
>              )
>            , ( "buffers_clean"
>              , ScalarType "int8"
>              )
>            , ( "maxwritten_clean"
>              , ScalarType "int8"
>              )
>            , ( "buffers_backend"
>              , ScalarType "int8"
>              )
>            , ( "buffers_alloc"
>              , ScalarType "int8"
>              )
>            ]
>        , EnvCreateView
>            "pg_stat_database"
>            [ ( "datid"
>              , ScalarType "oid"
>              )
>            , ( "datname"
>              , ScalarType "name"
>              )
>            , ( "numbackends"
>              , ScalarType "int4"
>              )
>            , ( "xact_commit"
>              , ScalarType "int8"
>              )
>            , ( "xact_rollback"
>              , ScalarType "int8"
>              )
>            , ( "blks_read"
>              , ScalarType "int8"
>              )
>            , ( "blks_hit"
>              , ScalarType "int8"
>              )
>            , ( "tup_returned"
>              , ScalarType "int8"
>              )
>            , ( "tup_fetched"
>              , ScalarType "int8"
>              )
>            , ( "tup_inserted"
>              , ScalarType "int8"
>              )
>            , ( "tup_updated"
>              , ScalarType "int8"
>              )
>            , ( "tup_deleted"
>              , ScalarType "int8"
>              )
>            ]
>        , EnvCreateView
>            "pg_stat_sys_indexes"
>            [ ( "relid"
>              , ScalarType "oid"
>              )
>            , ( "indexrelid"
>              , ScalarType "oid"
>              )
>            , ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "relname"
>              , ScalarType "name"
>              )
>            , ( "indexrelname"
>              , ScalarType "name"
>              )
>            , ( "idx_scan"
>              , ScalarType "int8"
>              )
>            , ( "idx_tup_read"
>              , ScalarType "int8"
>              )
>            , ( "idx_tup_fetch"
>              , ScalarType "int8"
>              )
>            ]
>        , EnvCreateView
>            "pg_stat_sys_tables"
>            [ ( "relid"
>              , ScalarType "oid"
>              )
>            , ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "relname"
>              , ScalarType "name"
>              )
>            , ( "seq_scan"
>              , ScalarType "int8"
>              )
>            , ( "seq_tup_read"
>              , ScalarType "int8"
>              )
>            , ( "idx_scan"
>              , ScalarType "int8"
>              )
>            , ( "idx_tup_fetch"
>              , ScalarType "int8"
>              )
>            , ( "n_tup_ins"
>              , ScalarType "int8"
>              )
>            , ( "n_tup_upd"
>              , ScalarType "int8"
>              )
>            , ( "n_tup_del"
>              , ScalarType "int8"
>              )
>            , ( "n_tup_hot_upd"
>              , ScalarType "int8"
>              )
>            , ( "n_live_tup"
>              , ScalarType "int8"
>              )
>            , ( "n_dead_tup"
>              , ScalarType "int8"
>              )
>            , ( "last_vacuum"
>              , ScalarType "timestamptz"
>              )
>            , ( "last_autovacuum"
>              , ScalarType "timestamptz"
>              )
>            , ( "last_analyze"
>              , ScalarType "timestamptz"
>              )
>            , ( "last_autoanalyze"
>              , ScalarType "timestamptz"
>              )
>            ]
>        , EnvCreateView
>            "pg_stat_user_functions"
>            [ ( "funcid"
>              , ScalarType "oid"
>              )
>            , ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "funcname"
>              , ScalarType "name"
>              )
>            , ( "calls"
>              , ScalarType "int8"
>              )
>            , ( "total_time"
>              , ScalarType "int8"
>              )
>            , ( "self_time"
>              , ScalarType "int8"
>              )
>            ]
>        , EnvCreateView
>            "pg_stat_user_indexes"
>            [ ( "relid"
>              , ScalarType "oid"
>              )
>            , ( "indexrelid"
>              , ScalarType "oid"
>              )
>            , ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "relname"
>              , ScalarType "name"
>              )
>            , ( "indexrelname"
>              , ScalarType "name"
>              )
>            , ( "idx_scan"
>              , ScalarType "int8"
>              )
>            , ( "idx_tup_read"
>              , ScalarType "int8"
>              )
>            , ( "idx_tup_fetch"
>              , ScalarType "int8"
>              )
>            ]
>        , EnvCreateView
>            "pg_stat_user_tables"
>            [ ( "relid"
>              , ScalarType "oid"
>              )
>            , ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "relname"
>              , ScalarType "name"
>              )
>            , ( "seq_scan"
>              , ScalarType "int8"
>              )
>            , ( "seq_tup_read"
>              , ScalarType "int8"
>              )
>            , ( "idx_scan"
>              , ScalarType "int8"
>              )
>            , ( "idx_tup_fetch"
>              , ScalarType "int8"
>              )
>            , ( "n_tup_ins"
>              , ScalarType "int8"
>              )
>            , ( "n_tup_upd"
>              , ScalarType "int8"
>              )
>            , ( "n_tup_del"
>              , ScalarType "int8"
>              )
>            , ( "n_tup_hot_upd"
>              , ScalarType "int8"
>              )
>            , ( "n_live_tup"
>              , ScalarType "int8"
>              )
>            , ( "n_dead_tup"
>              , ScalarType "int8"
>              )
>            , ( "last_vacuum"
>              , ScalarType "timestamptz"
>              )
>            , ( "last_autovacuum"
>              , ScalarType "timestamptz"
>              )
>            , ( "last_analyze"
>              , ScalarType "timestamptz"
>              )
>            , ( "last_autoanalyze"
>              , ScalarType "timestamptz"
>              )
>            ]
>        , EnvCreateView
>            "pg_statio_all_indexes"
>            [ ( "relid"
>              , ScalarType "oid"
>              )
>            , ( "indexrelid"
>              , ScalarType "oid"
>              )
>            , ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "relname"
>              , ScalarType "name"
>              )
>            , ( "indexrelname"
>              , ScalarType "name"
>              )
>            , ( "idx_blks_read"
>              , ScalarType "int8"
>              )
>            , ( "idx_blks_hit"
>              , ScalarType "int8"
>              )
>            ]
>        , EnvCreateView
>            "pg_statio_all_sequences"
>            [ ( "relid"
>              , ScalarType "oid"
>              )
>            , ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "relname"
>              , ScalarType "name"
>              )
>            , ( "blks_read"
>              , ScalarType "int8"
>              )
>            , ( "blks_hit"
>              , ScalarType "int8"
>              )
>            ]
>        , EnvCreateView
>            "pg_statio_all_tables"
>            [ ( "relid"
>              , ScalarType "oid"
>              )
>            , ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "relname"
>              , ScalarType "name"
>              )
>            , ( "heap_blks_read"
>              , ScalarType "int8"
>              )
>            , ( "heap_blks_hit"
>              , ScalarType "int8"
>              )
>            , ( "idx_blks_read"
>              , ScalarType "int8"
>              )
>            , ( "idx_blks_hit"
>              , ScalarType "int8"
>              )
>            , ( "toast_blks_read"
>              , ScalarType "int8"
>              )
>            , ( "toast_blks_hit"
>              , ScalarType "int8"
>              )
>            , ( "tidx_blks_read"
>              , ScalarType "int8"
>              )
>            , ( "tidx_blks_hit"
>              , ScalarType "int8"
>              )
>            ]
>        , EnvCreateView
>            "pg_statio_sys_indexes"
>            [ ( "relid"
>              , ScalarType "oid"
>              )
>            , ( "indexrelid"
>              , ScalarType "oid"
>              )
>            , ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "relname"
>              , ScalarType "name"
>              )
>            , ( "indexrelname"
>              , ScalarType "name"
>              )
>            , ( "idx_blks_read"
>              , ScalarType "int8"
>              )
>            , ( "idx_blks_hit"
>              , ScalarType "int8"
>              )
>            ]
>        , EnvCreateView
>            "pg_statio_sys_sequences"
>            [ ( "relid"
>              , ScalarType "oid"
>              )
>            , ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "relname"
>              , ScalarType "name"
>              )
>            , ( "blks_read"
>              , ScalarType "int8"
>              )
>            , ( "blks_hit"
>              , ScalarType "int8"
>              )
>            ]
>        , EnvCreateView
>            "pg_statio_sys_tables"
>            [ ( "relid"
>              , ScalarType "oid"
>              )
>            , ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "relname"
>              , ScalarType "name"
>              )
>            , ( "heap_blks_read"
>              , ScalarType "int8"
>              )
>            , ( "heap_blks_hit"
>              , ScalarType "int8"
>              )
>            , ( "idx_blks_read"
>              , ScalarType "int8"
>              )
>            , ( "idx_blks_hit"
>              , ScalarType "int8"
>              )
>            , ( "toast_blks_read"
>              , ScalarType "int8"
>              )
>            , ( "toast_blks_hit"
>              , ScalarType "int8"
>              )
>            , ( "tidx_blks_read"
>              , ScalarType "int8"
>              )
>            , ( "tidx_blks_hit"
>              , ScalarType "int8"
>              )
>            ]
>        , EnvCreateView
>            "pg_statio_user_indexes"
>            [ ( "relid"
>              , ScalarType "oid"
>              )
>            , ( "indexrelid"
>              , ScalarType "oid"
>              )
>            , ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "relname"
>              , ScalarType "name"
>              )
>            , ( "indexrelname"
>              , ScalarType "name"
>              )
>            , ( "idx_blks_read"
>              , ScalarType "int8"
>              )
>            , ( "idx_blks_hit"
>              , ScalarType "int8"
>              )
>            ]
>        , EnvCreateView
>            "pg_statio_user_sequences"
>            [ ( "relid"
>              , ScalarType "oid"
>              )
>            , ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "relname"
>              , ScalarType "name"
>              )
>            , ( "blks_read"
>              , ScalarType "int8"
>              )
>            , ( "blks_hit"
>              , ScalarType "int8"
>              )
>            ]
>        , EnvCreateView
>            "pg_statio_user_tables"
>            [ ( "relid"
>              , ScalarType "oid"
>              )
>            , ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "relname"
>              , ScalarType "name"
>              )
>            , ( "heap_blks_read"
>              , ScalarType "int8"
>              )
>            , ( "heap_blks_hit"
>              , ScalarType "int8"
>              )
>            , ( "idx_blks_read"
>              , ScalarType "int8"
>              )
>            , ( "idx_blks_hit"
>              , ScalarType "int8"
>              )
>            , ( "toast_blks_read"
>              , ScalarType "int8"
>              )
>            , ( "toast_blks_hit"
>              , ScalarType "int8"
>              )
>            , ( "tidx_blks_read"
>              , ScalarType "int8"
>              )
>            , ( "tidx_blks_hit"
>              , ScalarType "int8"
>              )
>            ]
>        , EnvCreateView
>            "pg_stats"
>            [ ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "tablename"
>              , ScalarType "name"
>              )
>            , ( "attname"
>              , ScalarType "name"
>              )
>            , ( "null_frac"
>              , ScalarType "float4"
>              )
>            , ( "avg_width"
>              , ScalarType "int4"
>              )
>            , ( "n_distinct"
>              , ScalarType "float4"
>              )
>            , ( "most_common_vals"
>              , Pseudo AnyArray
>              )
>            , ( "most_common_freqs"
>              , ArrayType ( ScalarType "float4" )
>              )
>            , ( "histogram_bounds"
>              , Pseudo AnyArray
>              )
>            , ( "correlation"
>              , ScalarType "float4"
>              )
>            ]
>        , EnvCreateView
>            "pg_tables"
>            [ ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "tablename"
>              , ScalarType "name"
>              )
>            , ( "tableowner"
>              , ScalarType "name"
>              )
>            , ( "tablespace"
>              , ScalarType "name"
>              )
>            , ( "hasindexes"
>              , ScalarType "bool"
>              )
>            , ( "hasrules"
>              , ScalarType "bool"
>              )
>            , ( "hastriggers"
>              , ScalarType "bool"
>              )
>            ]
>        , EnvCreateView
>            "pg_timezone_abbrevs"
>            [ ( "abbrev"
>              , ScalarType "text"
>              )
>            , ( "utc_offset"
>              , ScalarType "interval"
>              )
>            , ( "is_dst"
>              , ScalarType "bool"
>              )
>            ]
>        , EnvCreateView
>            "pg_timezone_names"
>            [ ( "name"
>              , ScalarType "text"
>              )
>            , ( "abbrev"
>              , ScalarType "text"
>              )
>            , ( "utc_offset"
>              , ScalarType "interval"
>              )
>            , ( "is_dst"
>              , ScalarType "bool"
>              )
>            ]
>        , EnvCreateView
>            "pg_user"
>            [ ( "usename"
>              , ScalarType "name"
>              )
>            , ( "usesysid"
>              , ScalarType "oid"
>              )
>            , ( "usecreatedb"
>              , ScalarType "bool"
>              )
>            , ( "usesuper"
>              , ScalarType "bool"
>              )
>            , ( "usecatupd"
>              , ScalarType "bool"
>              )
>            , ( "passwd"
>              , ScalarType "text"
>              )
>            , ( "valuntil"
>              , ScalarType "abstime"
>              )
>            , ( "useconfig"
>              , ArrayType ( ScalarType "text" )
>              )
>            ]
>        , EnvCreateView
>            "pg_user_mappings"
>            [ ( "umid"
>              , ScalarType "oid"
>              )
>            , ( "srvid"
>              , ScalarType "oid"
>              )
>            , ( "srvname"
>              , ScalarType "name"
>              )
>            , ( "umuser"
>              , ScalarType "oid"
>              )
>            , ( "usename"
>              , ScalarType "name"
>              )
>            , ( "umoptions"
>              , ArrayType ( ScalarType "text" )
>              )
>            ]
>        , EnvCreateView
>            "pg_views"
>            [ ( "schemaname"
>              , ScalarType "name"
>              )
>            , ( "viewname"
>              , ScalarType "name"
>              )
>            , ( "viewowner"
>              , ScalarType "name"
>              )
>            , ( "definition"
>              , ScalarType "text"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.referential_constraints"
>            [ ( "constraint_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "unique_constraint_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "unique_constraint_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "unique_constraint_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "match_option"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "update_rule"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "delete_rule"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.role_column_grants"
>            [ ( "grantor"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "grantee"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "column_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "privilege_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_grantable"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.role_routine_grants"
>            [ ( "grantor"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "grantee"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "specific_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "specific_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "specific_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "routine_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "routine_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "routine_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "privilege_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_grantable"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.role_table_grants"
>            [ ( "grantor"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "grantee"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "privilege_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_grantable"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "with_hierarchy"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.role_usage_grants"
>            [ ( "grantor"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "grantee"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "object_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "object_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "object_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "object_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "privilege_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_grantable"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.routine_privileges"
>            [ ( "grantor"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "grantee"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "specific_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "specific_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "specific_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "routine_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "routine_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "routine_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "privilege_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_grantable"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.routines"
>            [ ( "specific_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "specific_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "specific_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "routine_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "routine_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "routine_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "routine_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "module_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "module_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "module_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "udt_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "udt_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "udt_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "data_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "character_maximum_length"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "character_octet_length"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "character_set_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "character_set_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "character_set_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "collation_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "collation_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "collation_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "numeric_precision"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "numeric_precision_radix"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "numeric_scale"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "datetime_precision"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "interval_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "interval_precision"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "type_udt_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "type_udt_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "type_udt_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "scope_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "scope_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "scope_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "maximum_cardinality"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "dtd_identifier"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "routine_body"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "routine_definition"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "external_name"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "external_language"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "parameter_style"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_deterministic"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "sql_data_access"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_null_call"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "sql_path"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "schema_level_routine"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "max_dynamic_result_sets"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "is_user_defined_cast"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_implicitly_invocable"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "security_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "to_sql_specific_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "to_sql_specific_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "to_sql_specific_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "as_locator"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "created"
>              , DomainType "information_schema.time_stamp"
>              )
>            , ( "last_altered"
>              , DomainType "information_schema.time_stamp"
>              )
>            , ( "new_savepoint_level"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_udt_dependent"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "result_cast_from_data_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "result_cast_as_locator"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "result_cast_char_max_length"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "result_cast_char_octet_length"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "result_cast_char_set_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "result_cast_char_set_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "result_cast_character_set_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "result_cast_collation_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "result_cast_collation_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "result_cast_collation_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "result_cast_numeric_precision"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "result_cast_numeric_precision_radix"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "result_cast_numeric_scale"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "result_cast_datetime_precision"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "result_cast_interval_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "result_cast_interval_precision"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "result_cast_type_udt_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "result_cast_type_udt_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "result_cast_type_udt_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "result_cast_scope_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "result_cast_scope_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "result_cast_scope_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "result_cast_maximum_cardinality"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "result_cast_dtd_identifier"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.schemata"
>            [ ( "catalog_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "schema_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "schema_owner"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "default_character_set_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "default_character_set_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "default_character_set_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "sql_path"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.sequences"
>            [ ( "sequence_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "sequence_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "sequence_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "data_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "numeric_precision"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "numeric_precision_radix"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "numeric_scale"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "maximum_value"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "minimum_value"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "increment"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "cycle_option"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.table_constraints"
>            [ ( "constraint_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "constraint_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_deferrable"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "initially_deferred"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.table_privileges"
>            [ ( "grantor"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "grantee"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "privilege_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_grantable"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "with_hierarchy"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.tables"
>            [ ( "table_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "self_referencing_column_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "reference_generation"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "user_defined_type_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "user_defined_type_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "user_defined_type_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "is_insertable_into"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_typed"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "commit_action"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.triggered_update_columns"
>            [ ( "trigger_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "trigger_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "trigger_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "event_object_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "event_object_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "event_object_table"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "event_object_column"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.triggers"
>            [ ( "trigger_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "trigger_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "trigger_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "event_manipulation"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "event_object_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "event_object_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "event_object_table"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "action_order"
>              , DomainType "information_schema.cardinal_number"
>              )
>            , ( "action_condition"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "action_statement"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "action_orientation"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "condition_timing"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "condition_reference_old_table"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "condition_reference_new_table"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "condition_reference_old_row"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "condition_reference_new_row"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "created"
>              , DomainType "information_schema.time_stamp"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.usage_privileges"
>            [ ( "grantor"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "grantee"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "object_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "object_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "object_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "object_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "privilege_type"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_grantable"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.user_mapping_options"
>            [ ( "authorization_identifier"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_server_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_server_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "option_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "option_value"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.user_mappings"
>            [ ( "authorization_identifier"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_server_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "foreign_server_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.view_column_usage"
>            [ ( "view_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "view_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "view_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "column_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.view_routine_usage"
>            [ ( "table_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "specific_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "specific_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "specific_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.view_table_usage"
>            [ ( "view_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "view_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "view_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            ]
>        , EnvCreateView
>            "information_schema.views"
>            [ ( "table_catalog"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_schema"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "table_name"
>              , DomainType "information_schema.sql_identifier"
>              )
>            , ( "view_definition"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "check_option"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_updatable"
>              , DomainType "information_schema.character_data"
>              )
>            , ( "is_insertable_into"
>              , DomainType "information_schema.character_data"
>              )
>            ]
>        ]

