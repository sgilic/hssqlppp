

-- UUAGC 0.9.13 (AstInternal.ag)
module Database.HsSqlPpp.AstInternals.AstInternal(
    -- {-# LANGUAGE DeriveDataTypeable,RankNTypes,ScopedTypeVariables #-}
    -- {-# OPTIONS_HADDOCK hide  #-}
    --from the ag files:
    --ast nodes
    Statement (..)
   ,SelectExpression (..)
   ,FnBody (..)
   ,SetClause (..)
   ,TableRef (..)
   ,TableAlias(..)
   ,JoinExpression (..)
   ,JoinType (..)
   ,SelectList (..)
   ,SelectItem (..)
   ,CopySource (..)
   ,AttributeDef (..)
   ,RowConstraint (..)
   ,AlterTableAction(..)
   ,Constraint (..)
   ,TypeAttributeDef (..)
   ,ParamDef (..)
   ,VarDef (..)
   ,RaiseType (..)
   ,CombineType (..)
   ,Volatility (..)
   ,Language (..)
   ,TypeName (..)
   ,DropType (..)
   ,Cascade (..)
   ,Direction (..)
   ,Distinct (..)
   ,Natural (..)
   ,IfExists (..)
   ,RestartIdentity (..)
   ,Expression (..)
   ,FrameClause(..)
   ,InList (..)
   ,LiftFlavour(..)
   ,TriggerWhen(..)
   ,TriggerEvent(..)
   ,TriggerFire(..)
   ,StatementList
   ,ExpressionListStatementListPairList
   ,ExpressionListStatementListPair
   ,ExpressionList
   ,StringList
   ,ParamDefList
   ,AttributeDefList
   ,ConstraintList
   ,TypeAttributeDefList
   ,TypeNameList
   ,StringTypeNameListPair
   ,StringTypeNameListPairList
   ,ExpressionStatementListPairList
   ,SetClauseList
   ,CaseExpressionListExpressionPairList
   ,MaybeExpression
   ,TableRefList
   ,ExpressionListList
   ,SelectItemList
   ,OnExpr
   ,RowConstraintList
   ,VarDefList
   ,ExpressionStatementListPair
   ,CaseExpressionListExpressionPair
   ,CaseExpressionList
   ,ExpressionDirectionPair
   ,ExpressionDirectionPairList
   ,MaybeBoolExpression
   ,MaybeSelectList
   ,SetValue(..)
   -- typechecking
   ,typeCheck
   ,typeCheckPS
   ,typeCheckExpression
) where

import Data.Maybe
import Data.List
import Debug.Trace
--import Control.Monad.Error
import Data.Either
import Control.Applicative
import Data.Generics
import Data.Char
import Control.Monad.State

import Database.HsSqlPpp.AstInternals.TypeType
import Database.HsSqlPpp.AstInternals.TypeChecking.TypeConversion
import Database.HsSqlPpp.AstInternals.TypeChecking.ErrorUtils
import Database.HsSqlPpp.AstInternals.AstAnnotation
import Database.HsSqlPpp.AstInternals.Catalog.CatalogInternal
import Database.HsSqlPpp.AstInternals.TypeChecking.LocalBindings
--import Database.HsSqlPpp.AstInternals.Catalog.DefaultTemplate1Catalog
import Database.HsSqlPpp.Utils
import Data.Generics.PlateData


{-# LINE 683 "AstInternal.ag" #-}

{-
-- | Type check multiple asts, allowing type checking references in
--   later files to definitions in earlier files. This is probably
--   more straightforward if you parse the files then concatenate the
--   statementlists together before type checking rather than using
--   this function
typeCheckMany :: Catalog -> [StatementList] -> [StatementList]
typeCheckMany cat sts =
    annInt cat sts []
    where
      annInt e (s:ss) ress =
          let (e1,res) = typeCheck e s
          in annInt e1 ss (res:ress)
      annInt _ [] ress = reverse ress
-}

-- | Takes an ast, checks against catalog passed, and adds
--   annotations, including types, type errors, and statement info.
--   Returns the updated catalog as well as the annotated ast.
typeCheck :: Catalog -> StatementList -> (Catalog,StatementList)
typeCheck cat sts =
    let t = sem_Root (Root (fixupImplicitJoins sts))
        ta = wrap_Root t Inh_Root {cat_Inh_Root = cat
                                  ,lib_Inh_Root = emptyBindings}
        tl = annotatedTree_Syn_Root ta
        cat1 = producedCat_Syn_Root ta
   in case tl of
         Root r -> (cat1,r)

-- | Unfinished version of type check which can type check an
-- individual statement with ? or positional arg placeholders in
-- it. Will error if the statement isn't select, update, insert or
-- delete. For use in type checking embedded parameterized
-- statements. Does all typechecking and annotation that the regular
-- typecheck does.
typeCheckPS :: Catalog -> Statement -> Either String Statement
typeCheckPS cat st =
    case st of
      SelectStatement _ _ -> tc
      Insert _ _ _ _ _ -> tc
      Update _ _ _ _ _ -> tc
      Delete _ _ _ _ -> tc
      _ -> Left "requires select, update, insert or delete statement"
    where
      tc = let t = sem_Root (Root (fixupImplicitJoins [st]))
               ta = wrap_Root t Inh_Root {cat_Inh_Root = cat
                                         ,lib_Inh_Root = emptyBindings}
               tl = annotatedTree_Syn_Root ta
               cat1 = producedCat_Syn_Root ta
           in case tl of
                Root [st1] -> Right st1
                _ -> error "impossible happened in typeCheckPS!"


-- | Testing utility, mainly used to check an expression for type errors
-- or to get its type.
typeCheckExpression :: Catalog -> Expression -> Expression
typeCheckExpression cat ex =
    let t = sem_ExpressionRoot (ExpressionRoot (fixupImplicitJoins ex))
        rt = (annotatedTree_Syn_ExpressionRoot
              (wrap_ExpressionRoot t Inh_ExpressionRoot {cat_Inh_ExpressionRoot = cat
                                                        ,lib_Inh_ExpressionRoot = emptyBindings}))
    in case rt of
         ExpressionRoot e -> e

{-
bit of a hack, to avoid rewriting the tableref type checking to be
able to do implicit joins, we just convert them in to the equivalent
explicit join
-}

fixupImplicitJoins :: Data a => a -> a
fixupImplicitJoins =
    transformBi $ \x ->
            case x of
              -- alter asts to change implicit joins into explicit joins
              Select an dis sl trs@(_:_:_) whr grp hav ord lim off
                  -> Select an dis sl [convTrefs trs] whr grp hav ord lim off
              x1 -> x1
    where
      convTrefs (tr:tr1:trs) = JoinedTref [] tr Unnatural Cross (convTrefs (tr1:trs)) Nothing NoAlias
      convTrefs (tr:[]) = tr
      convTrefs _ = error "failed doing implicit join fixup hack"

{-# LINE 190 "AstInternal.hs" #-}

{-# LINE 81 "./TypeChecking/Misc.ag" #-}

{-
================================================================================

= couple of small utils

I think this should be alright, an identifier referenced in an
expression can only have zero or one dot in it.
-}

splitIdentifier :: String -> (String,String)
splitIdentifier s = let (a,b) = span (/= '.') s
                    in if b == ""
                         then ("", a)
                         else (a,tail b)

{-
helper to make adding annotations a bit easier
-}

annTypesAndErrors :: Data a => a -> Type -> [TypeError]
                  -> Maybe [AnnotationElement] -> a
annTypesAndErrors item nt errs add =
    updateAnnotation modifier item
    where
      modifier = (([TypeAnnotation nt] ++ fromMaybe [] add ++
       map TypeErrorA errs) ++)

{-
================================================================================

proper dodgy:
1st pass is to add inferred types to the tree. This is done only for
expressions in a funcall argument list atm. Then we pull out the
placeholders after they've had this information added. Only the
placeholders in funcall argument lists will have their type inferred
in this way, to be expanded. Insert also does this currently, but in Dml.ag

This should probably be done during the typechecking phase instead,
but probably needs a proper type inferencing algorithm to be used, is
done like this for development expediency.

-}
getPlaceholders :: Data a => a -> [Expression]
getPlaceholders st =
    filter isPlaceholder $ everything (++) (mkQ [] ga) (setInferredTypes st)
    where
      ga :: Expression -> [Expression]
      ga s = [s]
      isPlaceholder e = case e of
                          PositionalArg _ _ -> True
                          Placeholder _ -> True
                          _ -> False

getPlaceholderTypes :: Data a => a -> [Type]
getPlaceholderTypes ex =
    map (getInferredType . getAnnotation) $ getPlaceholders ex
    where
      getInferredType (InferredType t:_) = t
      getInferredType (_:as) = getInferredType as
      getInferredType [] = TypeCheckFailed


setInferredTypes :: Data a => a -> a
setInferredTypes =
      doExprs {-. doSts-}
     where
       doExprs =
         transformBi (\x ->
           case x of
             FunCall an op exprs
                 -> FunCall an op (addInferredTypes an exprs)
             x1 -> x1)
       {-doSts =
         transformBi (\x ->
           case x of
             Insert ann table targetCols insData returning
                 -> Insert ann table targetCols insData returning
             x1 -> x1)-}
       addInferredTypes an exprs =
           let args1 = fmap (\(_,a,_,_) -> a) $ fp an
               args = fromMaybe [] args1
               fargs = args ++ repeat TypeCheckFailed
           in flip map (zip exprs fargs)
                  (\(ex, ty) -> updateAnnotation (++ [InferredType ty]) ex)
           where
             fp (FunctionPrototypeA f:_) = Just f
             fp (_:ls) = fp ls
             fp [] = Nothing

{-# LINE 283 "AstInternal.hs" #-}

{-# LINE 94 "./TypeChecking/Expressions.ag" #-}

{-

small shim in front of findCallMatch in the type conversion code, to
handle some special cases.

Some of the special cases will no longer be needed when variadic
support is added.

between, greatest and least are treated as syntactic sugar so we
delegate the function lookups to the <=/>= operators.

the row comparison should be more general than this, since it supports
any operator satisfying some properties


TODO: move all of this into find call match. Don't know why it's separate
-}
typeCheckFunCall :: Catalog -> String -> [Type] -> Either [TypeError] FunctionPrototype
typeCheckFunCall cat fnName' argsType =
    {-trace ("typecheckfncall " ++ fnName' ++ show argsType) $-}
    --dependsOnRTpe argsType $
      case fnName of
              "count" -> -- not quite sure how this is suppose to work,
                         -- the counts in the pg catalog accept either
                         -- no args, or one arg of type any, but you can call
                         -- count with multiple arguments?
                         return ("count", argsType, typeBigInt, False)
              "!between" -> do
                    f1 <- lookupReturnType ">=" [argsType !! 0, argsType !! 1]
                    f2 <- lookupReturnType "<=" [argsType !! 0, argsType !! 2]
                    lookupFn "!and" [f1,f2]
              "greatest" -> do
                    fp@(_,_,t,_) <- lookupFn fnName argsType
                    lookupFn ">=" [t,t]
                    return fp
              "least" -> do
                    fp@(_,_,t,_) <- lookupFn fnName argsType
                    lookupFn "<=" [t,t]
                    return fp
              "!rowctor" -> return $ ("!rowCtor", argsType, AnonymousRecordType argsType, False)
                    -- special case the row comparison ops
                    -- this needs to be fixed: we want to match
                    -- any implicit casts to functions on composite types
                    -- first, then we can use the anonymous record type on
                    -- any composite
              _ | fnName `elem` ["=", "<>", "<=", ">=", "<", ">"]
                         && length argsType == 2
                         && all isCompositeOrSetOfCompositeType argsType
                         && compositesCompatible cat (head argsType) (head $ tail argsType) -> return (fnName, argsType, typeBool, False)
              --checked for all special cases, so run general case now
              s -> lookupFn s argsType
    where
      lookupReturnType :: String -> [Type] -> Either [TypeError] Type
      lookupReturnType s1 args = fmap (\(_,_,r,_) -> r) $ lookupFn s1 args
      lookupFn :: String -> [Type] -> Either [TypeError] FunctionPrototype
      lookupFn s1 args = findCallMatch cat
                             (if s1 == "u-" then "-" else s1) args
      fnName = map toLower fnName'
{-# LINE 345 "AstInternal.hs" #-}

{-# LINE 138 "./TypeChecking/SelectStatement.ag" #-}


typeCheckValuesExpr :: Catalog -> [[Type]] -> Either [TypeError] Type
typeCheckValuesExpr cat rowsTs =
        let colNames = zipWith (++)
                           (repeat "column")
                           (map show [1..length $ head rowsTs])
        in unionRelTypes cat rowsTs colNames


typeCheckCombineSelect :: Catalog -> Type -> Type -> Either [TypeError] Type
typeCheckCombineSelect cat v1 v2 = do
    u1 <- unwrapSetOfComposite v1
    let colNames = map fst u1
    u2 <- unwrapSetOfComposite v2
    let colTypes1 = map snd u1
    let colTypes2 = map snd u2
    unionRelTypes cat [colTypes1,colTypes2] colNames

unionRelTypes :: Catalog -> [[Type]] -> [String] -> Either [TypeError] Type
unionRelTypes cat rowsTs colNames =
  let lengths = map length rowsTs
  in case () of
             _ | null rowsTs ->
                   Left [NoRowsGivenForValues]
               | not (all (==head lengths) lengths) ->
                   Left [ValuesListsMustBeSameLength]
               | otherwise ->
                   --i don't think this propagates all the errors, just the first set
                   mapM (resolveResultSetType cat) (transpose rowsTs) >>=
                     (return . SetOfType . CompositeType . zip colNames)

{-# LINE 380 "AstInternal.hs" #-}

{-# LINE 209 "./TypeChecking/TableRefs.ag" #-}




{-
convert a function call into a [String,[(string,type)]] list for use
in a tableref context
first consideration is the alias: if there is an alias in the select,
e.g. select * from generate_series(1,2) x;  (alias is x)
we use that, otherwise we use the name of the function
second consideration is the attributes coming out, roughly speaking
we have to convert an arbitrary type to a relation type
if we have a relation valued function, we don't need to do anything
if we have a setof non composite, we lift the single type to an
attribute, using the function name for the attribute name
if we have a non setof, we lift the single type to an attribute and
then relation, using the function name for the attribute name
need to check to see what should happen with arrayof

-}
funIdens :: Catalog -> String -> Expression -> Either [TypeError] (String,[(String,Type)])
funIdens cat alias fnVal = do
   errorWhen (case fnVal of
                FunCall _ _ _ -> False
                _ -> True)
             [ContextError "FunCall"]
   let (FunCall _ fnName _) = fnVal
       correlationName = if alias /= ""
                           then alias
                           else fnName
   attrs <- do
     case getTypeAnnotation fnVal of
       SetOfType (NamedCompositeType t) -> catCompositePublicAttrs cat [] t
       SetOfType x -> return [(correlationName,x)]
       y -> return [(correlationName,y)]
   return (correlationName, attrs)

getAlias :: String -> TableAlias -> String
getAlias def alias =
  case alias of
    NoAlias -> def
    TableAlias t -> t
    FullAlias t _ -> t

{-# LINE 427 "AstInternal.hs" #-}

{-# LINE 93 "./TypeChecking/SelectLists.ag" #-}

expandStar :: LocalBindings
           -> String
           -> Type
           -> [(String,Type)]
           -> [(String,Type)]
expandStar lb colName colType types =
    fromRight types $ do
    let (correlationName,iden) = splitIdentifier colName
    newCols <- if iden == "*"
                 then lbExpandStar lb correlationName
                 else return [(iden, colType)]
    return $ newCols ++ types

fixStar :: Expression -> Expression
fixStar =
    everywhere (mkT fixStar')
    where
      fixStar' :: Annotation -> Annotation
      fixStar' a =
          if TypeAnnotation TypeCheckFailed `elem` a
              && any (\an ->
                       case an of
                         TypeErrorA (UnrecognisedIdentifier x) |
                           let (_,iden) = splitIdentifier x
                           in iden == "*" -> True
                         _ -> False) a
             then filter (\an -> case an of
                                   TypeAnnotation TypeCheckFailed -> False
                                   TypeErrorA (UnrecognisedIdentifier _) -> False
                                   _ -> True) a
             else a
{-# LINE 462 "AstInternal.hs" #-}

{-# LINE 96 "./TypeChecking/Dml.ag" #-}


setInferredTypesG :: Data a => [Type] -> a -> a
setInferredTypesG tys x =
  evalState (transformBiM f x) tys
  where
    f (p@(Placeholder _)) = do
         y:ys <- get
         put ys
         return $ updateAnnotation (++ [InferredType y]) p
    f z = return z
{-# LINE 476 "AstInternal.hs" #-}

{-# LINE 163 "./TypeChecking/Dml.ag" #-}

getRowTypes :: [Type] -> [Type]
getRowTypes [AnonymousRecordType ts] = ts
getRowTypes ts = ts
{-# LINE 483 "AstInternal.hs" #-}

{-# LINE 202 "./TypeChecking/Dml.ag" #-}


--small shortcut to help produce better errors?
checkRelationExists :: Catalog -> String -> Either [TypeError] ()
checkRelationExists cat tbl =
    catCompositeDef cat relationComposites tbl >>
    return ()

--used by both insert and update
checkColumnConsistency :: Catalog ->  String -> [String] -> [(String,Type)]
                       -> Either [TypeError] [(String,Type)]
checkColumnConsistency cat tbl cols' insNameTypePairs = do
  ttcols <- lowerize <$> catCompositePublicAttrs cat [] tbl
  let cols = if null cols'
               then map fst ttcols
               else map (map toLower) cols'
  errorWhen (length insNameTypePairs /= length cols) [WrongNumberOfColumns]
  let nonMatchingColumns = cols \\ map fst ttcols
  errorWhen (not $ null nonMatchingColumns) $
       map UnrecognisedIdentifier nonMatchingColumns
  let targetNameTypePairs = map (\l -> (l,fromJust $ lookup l ttcols)) cols
        --check the types of the insdata match the column targets
        --name datatype columntype
      typeTriples = map (\((a,b),c) -> (a,b,c)) $
                    zip targetNameTypePairs $
                    map snd insNameTypePairs
      errs :: [TypeError]
      errs = concat $ lefts $
             map (\(_,b,c) -> checkAssignmentValid cat c b) typeTriples
  liftErrors errs
  return targetNameTypePairs
  where
    lowerize = map (\(a,b) -> (map toLower a,b))

{-# LINE 520 "AstInternal.hs" #-}

{-# LINE 40 "./TypeChecking/CreateTable.ag" #-}

defaultSystemColumns :: [(String,Type)]
defaultSystemColumns = [("tableoid", ScalarType "oid")
                       ,("cmax", ScalarType "cid")
                       ,("xmax", ScalarType "xid")
                       ,("cmin", ScalarType "cid")
                       ,("xmin", ScalarType "xid")
                       ,("ctid", ScalarType "tid")]
{-# LINE 531 "AstInternal.hs" #-}
-- AlterTableAction --------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative AddConstraint:
         child ann            : {Annotation}
         child con            : Constraint 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative AlterColumnDefault:
         child ann            : {Annotation}
         child nm             : {String}
         child def            : Expression 
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data AlterTableAction  = AddConstraint (Annotation) (Constraint) 
                       | AlterColumnDefault (Annotation) (String) (Expression) 
                       deriving ( Data,Eq,Show,Typeable)
-- cata
sem_AlterTableAction :: AlterTableAction  ->
                        T_AlterTableAction 
sem_AlterTableAction (AddConstraint _ann _con )  =
    (sem_AlterTableAction_AddConstraint _ann (sem_Constraint _con ) )
sem_AlterTableAction (AlterColumnDefault _ann _nm _def )  =
    (sem_AlterTableAction_AlterColumnDefault _ann _nm (sem_Expression _def ) )
-- semantic domain
type T_AlterTableAction  = Catalog ->
                           LocalBindings ->
                           ( AlterTableAction,AlterTableAction)
data Inh_AlterTableAction  = Inh_AlterTableAction {cat_Inh_AlterTableAction :: Catalog,lib_Inh_AlterTableAction :: LocalBindings}
data Syn_AlterTableAction  = Syn_AlterTableAction {annotatedTree_Syn_AlterTableAction :: AlterTableAction,originalTree_Syn_AlterTableAction :: AlterTableAction}
wrap_AlterTableAction :: T_AlterTableAction  ->
                         Inh_AlterTableAction  ->
                         Syn_AlterTableAction 
wrap_AlterTableAction sem (Inh_AlterTableAction _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_AlterTableAction _lhsOannotatedTree _lhsOoriginalTree ))
sem_AlterTableAction_AddConstraint :: Annotation ->
                                      T_Constraint  ->
                                      T_AlterTableAction 
sem_AlterTableAction_AddConstraint ann_ con_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: AlterTableAction
              _lhsOoriginalTree :: AlterTableAction
              _conOcat :: Catalog
              _conOlib :: LocalBindings
              _conIannotatedTree :: Constraint
              _conIoriginalTree :: Constraint
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  AddConstraint ann_ _conIannotatedTree
                  {-# LINE 595 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  AddConstraint ann_ _conIoriginalTree
                  {-# LINE 600 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 605 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 610 "AstInternal.hs" #-}
              -- copy rule (down)
              _conOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 615 "AstInternal.hs" #-}
              -- copy rule (down)
              _conOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 620 "AstInternal.hs" #-}
              ( _conIannotatedTree,_conIoriginalTree) =
                  (con_ _conOcat _conOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_AlterTableAction_AlterColumnDefault :: Annotation ->
                                           String ->
                                           T_Expression  ->
                                           T_AlterTableAction 
sem_AlterTableAction_AlterColumnDefault ann_ nm_ def_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: AlterTableAction
              _lhsOoriginalTree :: AlterTableAction
              _defOcat :: Catalog
              _defOlib :: LocalBindings
              _defIannotatedTree :: Expression
              _defIliftedColumnName :: String
              _defIoriginalTree :: Expression
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  AlterColumnDefault ann_ nm_ _defIannotatedTree
                  {-# LINE 642 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  AlterColumnDefault ann_ nm_ _defIoriginalTree
                  {-# LINE 647 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 652 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 657 "AstInternal.hs" #-}
              -- copy rule (down)
              _defOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 662 "AstInternal.hs" #-}
              -- copy rule (down)
              _defOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 667 "AstInternal.hs" #-}
              ( _defIannotatedTree,_defIliftedColumnName,_defIoriginalTree) =
                  (def_ _defOcat _defOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- AttributeDef ------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         attrName             : String
         namedType            : Type
         originalTree         : SELF 
   alternatives:
      alternative AttributeDef:
         child ann            : {Annotation}
         child name           : {String}
         child typ            : TypeName 
         child def            : MaybeExpression 
         child cons           : RowConstraintList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data AttributeDef  = AttributeDef (Annotation) (String) (TypeName) (MaybeExpression) (RowConstraintList) 
                   deriving ( Data,Eq,Show,Typeable)
-- cata
sem_AttributeDef :: AttributeDef  ->
                    T_AttributeDef 
sem_AttributeDef (AttributeDef _ann _name _typ _def _cons )  =
    (sem_AttributeDef_AttributeDef _ann _name (sem_TypeName _typ ) (sem_MaybeExpression _def ) (sem_RowConstraintList _cons ) )
-- semantic domain
type T_AttributeDef  = Catalog ->
                       LocalBindings ->
                       ( AttributeDef,String,Type,AttributeDef)
data Inh_AttributeDef  = Inh_AttributeDef {cat_Inh_AttributeDef :: Catalog,lib_Inh_AttributeDef :: LocalBindings}
data Syn_AttributeDef  = Syn_AttributeDef {annotatedTree_Syn_AttributeDef :: AttributeDef,attrName_Syn_AttributeDef :: String,namedType_Syn_AttributeDef :: Type,originalTree_Syn_AttributeDef :: AttributeDef}
wrap_AttributeDef :: T_AttributeDef  ->
                     Inh_AttributeDef  ->
                     Syn_AttributeDef 
wrap_AttributeDef sem (Inh_AttributeDef _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOattrName,_lhsOnamedType,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_AttributeDef _lhsOannotatedTree _lhsOattrName _lhsOnamedType _lhsOoriginalTree ))
sem_AttributeDef_AttributeDef :: Annotation ->
                                 String ->
                                 T_TypeName  ->
                                 T_MaybeExpression  ->
                                 T_RowConstraintList  ->
                                 T_AttributeDef 
sem_AttributeDef_AttributeDef ann_ name_ typ_ def_ cons_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOattrName :: String
              _lhsOnamedType :: Type
              _consOlib :: LocalBindings
              _lhsOannotatedTree :: AttributeDef
              _lhsOoriginalTree :: AttributeDef
              _typOcat :: Catalog
              _typOlib :: LocalBindings
              _defOcat :: Catalog
              _defOlib :: LocalBindings
              _consOcat :: Catalog
              _typIannotatedTree :: TypeName
              _typInamedType :: Type
              _typIoriginalTree :: TypeName
              _defIannotatedTree :: MaybeExpression
              _defIoriginalTree :: MaybeExpression
              _consIannotatedTree :: RowConstraintList
              _consIoriginalTree :: RowConstraintList
              -- "./TypeChecking/CreateTable.ag"(line 79, column 9)
              _lhsOattrName =
                  {-# LINE 79 "./TypeChecking/CreateTable.ag" #-}
                  map toLower name_
                  {-# LINE 743 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateTable.ag"(line 80, column 9)
              _lhsOnamedType =
                  {-# LINE 80 "./TypeChecking/CreateTable.ag" #-}
                  _typInamedType
                  {-# LINE 748 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateTable.ag"(line 95, column 9)
              _consOlib =
                  {-# LINE 95 "./TypeChecking/CreateTable.ag" #-}
                  case lbUpdate _lhsIcat _lhsIlib $
                         LBIds "attribute def" ""
                                          [(name_, _typInamedType)] [] of
                    Left x -> error $ "attributedef-cons.lib " ++ show x
                    Right e -> e
                  {-# LINE 757 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  AttributeDef ann_ name_ _typIannotatedTree _defIannotatedTree _consIannotatedTree
                  {-# LINE 762 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  AttributeDef ann_ name_ _typIoriginalTree _defIoriginalTree _consIoriginalTree
                  {-# LINE 767 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 772 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 777 "AstInternal.hs" #-}
              -- copy rule (down)
              _typOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 782 "AstInternal.hs" #-}
              -- copy rule (down)
              _typOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 787 "AstInternal.hs" #-}
              -- copy rule (down)
              _defOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 792 "AstInternal.hs" #-}
              -- copy rule (down)
              _defOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 797 "AstInternal.hs" #-}
              -- copy rule (down)
              _consOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 802 "AstInternal.hs" #-}
              ( _typIannotatedTree,_typInamedType,_typIoriginalTree) =
                  (typ_ _typOcat _typOlib )
              ( _defIannotatedTree,_defIoriginalTree) =
                  (def_ _defOcat _defOlib )
              ( _consIannotatedTree,_consIoriginalTree) =
                  (cons_ _consOcat _consOlib )
          in  ( _lhsOannotatedTree,_lhsOattrName,_lhsOnamedType,_lhsOoriginalTree)))
-- AttributeDefList --------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         attrs                : [(String, Type)]
         originalTree         : SELF 
   alternatives:
      alternative Cons:
         child hd             : AttributeDef 
         child tl             : AttributeDefList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type AttributeDefList  = [(AttributeDef)]
-- cata
sem_AttributeDefList :: AttributeDefList  ->
                        T_AttributeDefList 
sem_AttributeDefList list  =
    (Prelude.foldr sem_AttributeDefList_Cons sem_AttributeDefList_Nil (Prelude.map sem_AttributeDef list) )
-- semantic domain
type T_AttributeDefList  = Catalog ->
                           LocalBindings ->
                           ( AttributeDefList,([(String, Type)]),AttributeDefList)
data Inh_AttributeDefList  = Inh_AttributeDefList {cat_Inh_AttributeDefList :: Catalog,lib_Inh_AttributeDefList :: LocalBindings}
data Syn_AttributeDefList  = Syn_AttributeDefList {annotatedTree_Syn_AttributeDefList :: AttributeDefList,attrs_Syn_AttributeDefList :: [(String, Type)],originalTree_Syn_AttributeDefList :: AttributeDefList}
wrap_AttributeDefList :: T_AttributeDefList  ->
                         Inh_AttributeDefList  ->
                         Syn_AttributeDefList 
wrap_AttributeDefList sem (Inh_AttributeDefList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOattrs,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_AttributeDefList _lhsOannotatedTree _lhsOattrs _lhsOoriginalTree ))
sem_AttributeDefList_Cons :: T_AttributeDef  ->
                             T_AttributeDefList  ->
                             T_AttributeDefList 
sem_AttributeDefList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOattrs :: ([(String, Type)])
              _lhsOannotatedTree :: AttributeDefList
              _lhsOoriginalTree :: AttributeDefList
              _hdOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _hdIannotatedTree :: AttributeDef
              _hdIattrName :: String
              _hdInamedType :: Type
              _hdIoriginalTree :: AttributeDef
              _tlIannotatedTree :: AttributeDefList
              _tlIattrs :: ([(String, Type)])
              _tlIoriginalTree :: AttributeDefList
              -- "./TypeChecking/CreateTable.ag"(line 85, column 12)
              _lhsOattrs =
                  {-# LINE 85 "./TypeChecking/CreateTable.ag" #-}
                  (_hdIattrName, _hdInamedType) : _tlIattrs
                  {-# LINE 875 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 880 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 885 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 890 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 895 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 900 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 905 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 910 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 915 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdIattrName,_hdInamedType,_hdIoriginalTree) =
                  (hd_ _hdOcat _hdOlib )
              ( _tlIannotatedTree,_tlIattrs,_tlIoriginalTree) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOattrs,_lhsOoriginalTree)))
sem_AttributeDefList_Nil :: T_AttributeDefList 
sem_AttributeDefList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOattrs :: ([(String, Type)])
              _lhsOannotatedTree :: AttributeDefList
              _lhsOoriginalTree :: AttributeDefList
              -- "./TypeChecking/CreateTable.ag"(line 86, column 11)
              _lhsOattrs =
                  {-# LINE 86 "./TypeChecking/CreateTable.ag" #-}
                  []
                  {-# LINE 932 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 937 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 942 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 947 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 952 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOattrs,_lhsOoriginalTree)))
-- Cascade -----------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Cascade:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Restrict:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data Cascade  = Cascade 
              | Restrict 
              deriving ( Data,Eq,Show,Typeable)
-- cata
sem_Cascade :: Cascade  ->
               T_Cascade 
sem_Cascade (Cascade )  =
    (sem_Cascade_Cascade )
sem_Cascade (Restrict )  =
    (sem_Cascade_Restrict )
-- semantic domain
type T_Cascade  = Catalog ->
                  LocalBindings ->
                  ( Cascade,Cascade)
data Inh_Cascade  = Inh_Cascade {cat_Inh_Cascade :: Catalog,lib_Inh_Cascade :: LocalBindings}
data Syn_Cascade  = Syn_Cascade {annotatedTree_Syn_Cascade :: Cascade,originalTree_Syn_Cascade :: Cascade}
wrap_Cascade :: T_Cascade  ->
                Inh_Cascade  ->
                Syn_Cascade 
wrap_Cascade sem (Inh_Cascade _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_Cascade _lhsOannotatedTree _lhsOoriginalTree ))
sem_Cascade_Cascade :: T_Cascade 
sem_Cascade_Cascade  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Cascade
              _lhsOoriginalTree :: Cascade
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Cascade
                  {-# LINE 1006 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Cascade
                  {-# LINE 1011 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 1016 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 1021 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_Cascade_Restrict :: T_Cascade 
sem_Cascade_Restrict  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Cascade
              _lhsOoriginalTree :: Cascade
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Restrict
                  {-# LINE 1033 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Restrict
                  {-# LINE 1038 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 1043 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 1048 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- CaseExpressionList ------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Cons:
         child hd             : Expression 
         child tl             : CaseExpressionList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type CaseExpressionList  = [(Expression)]
-- cata
sem_CaseExpressionList :: CaseExpressionList  ->
                          T_CaseExpressionList 
sem_CaseExpressionList list  =
    (Prelude.foldr sem_CaseExpressionList_Cons sem_CaseExpressionList_Nil (Prelude.map sem_Expression list) )
-- semantic domain
type T_CaseExpressionList  = Catalog ->
                             LocalBindings ->
                             ( CaseExpressionList,CaseExpressionList)
data Inh_CaseExpressionList  = Inh_CaseExpressionList {cat_Inh_CaseExpressionList :: Catalog,lib_Inh_CaseExpressionList :: LocalBindings}
data Syn_CaseExpressionList  = Syn_CaseExpressionList {annotatedTree_Syn_CaseExpressionList :: CaseExpressionList,originalTree_Syn_CaseExpressionList :: CaseExpressionList}
wrap_CaseExpressionList :: T_CaseExpressionList  ->
                           Inh_CaseExpressionList  ->
                           Syn_CaseExpressionList 
wrap_CaseExpressionList sem (Inh_CaseExpressionList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_CaseExpressionList _lhsOannotatedTree _lhsOoriginalTree ))
sem_CaseExpressionList_Cons :: T_Expression  ->
                               T_CaseExpressionList  ->
                               T_CaseExpressionList 
sem_CaseExpressionList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: CaseExpressionList
              _lhsOoriginalTree :: CaseExpressionList
              _hdOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _hdIannotatedTree :: Expression
              _hdIliftedColumnName :: String
              _hdIoriginalTree :: Expression
              _tlIannotatedTree :: CaseExpressionList
              _tlIoriginalTree :: CaseExpressionList
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 1111 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 1116 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 1121 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 1126 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 1131 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 1136 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 1141 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 1146 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdIliftedColumnName,_hdIoriginalTree) =
                  (hd_ _hdOcat _hdOlib )
              ( _tlIannotatedTree,_tlIoriginalTree) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_CaseExpressionList_Nil :: T_CaseExpressionList 
sem_CaseExpressionList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: CaseExpressionList
              _lhsOoriginalTree :: CaseExpressionList
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 1162 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 1167 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 1172 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 1177 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- CaseExpressionListExpressionPair ----------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Tuple:
         child x1             : CaseExpressionList 
         child x2             : Expression 
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type CaseExpressionListExpressionPair  = ( (CaseExpressionList),(Expression))
-- cata
sem_CaseExpressionListExpressionPair :: CaseExpressionListExpressionPair  ->
                                        T_CaseExpressionListExpressionPair 
sem_CaseExpressionListExpressionPair ( x1,x2)  =
    (sem_CaseExpressionListExpressionPair_Tuple (sem_CaseExpressionList x1 ) (sem_Expression x2 ) )
-- semantic domain
type T_CaseExpressionListExpressionPair  = Catalog ->
                                           LocalBindings ->
                                           ( CaseExpressionListExpressionPair,CaseExpressionListExpressionPair)
data Inh_CaseExpressionListExpressionPair  = Inh_CaseExpressionListExpressionPair {cat_Inh_CaseExpressionListExpressionPair :: Catalog,lib_Inh_CaseExpressionListExpressionPair :: LocalBindings}
data Syn_CaseExpressionListExpressionPair  = Syn_CaseExpressionListExpressionPair {annotatedTree_Syn_CaseExpressionListExpressionPair :: CaseExpressionListExpressionPair,originalTree_Syn_CaseExpressionListExpressionPair :: CaseExpressionListExpressionPair}
wrap_CaseExpressionListExpressionPair :: T_CaseExpressionListExpressionPair  ->
                                         Inh_CaseExpressionListExpressionPair  ->
                                         Syn_CaseExpressionListExpressionPair 
wrap_CaseExpressionListExpressionPair sem (Inh_CaseExpressionListExpressionPair _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_CaseExpressionListExpressionPair _lhsOannotatedTree _lhsOoriginalTree ))
sem_CaseExpressionListExpressionPair_Tuple :: T_CaseExpressionList  ->
                                              T_Expression  ->
                                              T_CaseExpressionListExpressionPair 
sem_CaseExpressionListExpressionPair_Tuple x1_ x2_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: CaseExpressionListExpressionPair
              _lhsOoriginalTree :: CaseExpressionListExpressionPair
              _x1Ocat :: Catalog
              _x1Olib :: LocalBindings
              _x2Ocat :: Catalog
              _x2Olib :: LocalBindings
              _x1IannotatedTree :: CaseExpressionList
              _x1IoriginalTree :: CaseExpressionList
              _x2IannotatedTree :: Expression
              _x2IliftedColumnName :: String
              _x2IoriginalTree :: Expression
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (_x1IannotatedTree,_x2IannotatedTree)
                  {-# LINE 1236 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (_x1IoriginalTree,_x2IoriginalTree)
                  {-# LINE 1241 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 1246 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 1251 "AstInternal.hs" #-}
              -- copy rule (down)
              _x1Ocat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 1256 "AstInternal.hs" #-}
              -- copy rule (down)
              _x1Olib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 1261 "AstInternal.hs" #-}
              -- copy rule (down)
              _x2Ocat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 1266 "AstInternal.hs" #-}
              -- copy rule (down)
              _x2Olib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 1271 "AstInternal.hs" #-}
              ( _x1IannotatedTree,_x1IoriginalTree) =
                  (x1_ _x1Ocat _x1Olib )
              ( _x2IannotatedTree,_x2IliftedColumnName,_x2IoriginalTree) =
                  (x2_ _x2Ocat _x2Olib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- CaseExpressionListExpressionPairList ------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Cons:
         child hd             : CaseExpressionListExpressionPair 
         child tl             : CaseExpressionListExpressionPairList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type CaseExpressionListExpressionPairList  = [(CaseExpressionListExpressionPair)]
-- cata
sem_CaseExpressionListExpressionPairList :: CaseExpressionListExpressionPairList  ->
                                            T_CaseExpressionListExpressionPairList 
sem_CaseExpressionListExpressionPairList list  =
    (Prelude.foldr sem_CaseExpressionListExpressionPairList_Cons sem_CaseExpressionListExpressionPairList_Nil (Prelude.map sem_CaseExpressionListExpressionPair list) )
-- semantic domain
type T_CaseExpressionListExpressionPairList  = Catalog ->
                                               LocalBindings ->
                                               ( CaseExpressionListExpressionPairList,CaseExpressionListExpressionPairList)
data Inh_CaseExpressionListExpressionPairList  = Inh_CaseExpressionListExpressionPairList {cat_Inh_CaseExpressionListExpressionPairList :: Catalog,lib_Inh_CaseExpressionListExpressionPairList :: LocalBindings}
data Syn_CaseExpressionListExpressionPairList  = Syn_CaseExpressionListExpressionPairList {annotatedTree_Syn_CaseExpressionListExpressionPairList :: CaseExpressionListExpressionPairList,originalTree_Syn_CaseExpressionListExpressionPairList :: CaseExpressionListExpressionPairList}
wrap_CaseExpressionListExpressionPairList :: T_CaseExpressionListExpressionPairList  ->
                                             Inh_CaseExpressionListExpressionPairList  ->
                                             Syn_CaseExpressionListExpressionPairList 
wrap_CaseExpressionListExpressionPairList sem (Inh_CaseExpressionListExpressionPairList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_CaseExpressionListExpressionPairList _lhsOannotatedTree _lhsOoriginalTree ))
sem_CaseExpressionListExpressionPairList_Cons :: T_CaseExpressionListExpressionPair  ->
                                                 T_CaseExpressionListExpressionPairList  ->
                                                 T_CaseExpressionListExpressionPairList 
sem_CaseExpressionListExpressionPairList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: CaseExpressionListExpressionPairList
              _lhsOoriginalTree :: CaseExpressionListExpressionPairList
              _hdOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _hdIannotatedTree :: CaseExpressionListExpressionPair
              _hdIoriginalTree :: CaseExpressionListExpressionPair
              _tlIannotatedTree :: CaseExpressionListExpressionPairList
              _tlIoriginalTree :: CaseExpressionListExpressionPairList
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 1337 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 1342 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 1347 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 1352 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 1357 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 1362 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 1367 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 1372 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdIoriginalTree) =
                  (hd_ _hdOcat _hdOlib )
              ( _tlIannotatedTree,_tlIoriginalTree) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_CaseExpressionListExpressionPairList_Nil :: T_CaseExpressionListExpressionPairList 
sem_CaseExpressionListExpressionPairList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: CaseExpressionListExpressionPairList
              _lhsOoriginalTree :: CaseExpressionListExpressionPairList
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 1388 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 1393 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 1398 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 1403 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- CombineType -------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Except:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Intersect:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Union:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative UnionAll:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data CombineType  = Except 
                  | Intersect 
                  | Union 
                  | UnionAll 
                  deriving ( Data,Eq,Show,Typeable)
-- cata
sem_CombineType :: CombineType  ->
                   T_CombineType 
sem_CombineType (Except )  =
    (sem_CombineType_Except )
sem_CombineType (Intersect )  =
    (sem_CombineType_Intersect )
sem_CombineType (Union )  =
    (sem_CombineType_Union )
sem_CombineType (UnionAll )  =
    (sem_CombineType_UnionAll )
-- semantic domain
type T_CombineType  = Catalog ->
                      LocalBindings ->
                      ( CombineType,CombineType)
data Inh_CombineType  = Inh_CombineType {cat_Inh_CombineType :: Catalog,lib_Inh_CombineType :: LocalBindings}
data Syn_CombineType  = Syn_CombineType {annotatedTree_Syn_CombineType :: CombineType,originalTree_Syn_CombineType :: CombineType}
wrap_CombineType :: T_CombineType  ->
                    Inh_CombineType  ->
                    Syn_CombineType 
wrap_CombineType sem (Inh_CombineType _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_CombineType _lhsOannotatedTree _lhsOoriginalTree ))
sem_CombineType_Except :: T_CombineType 
sem_CombineType_Except  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: CombineType
              _lhsOoriginalTree :: CombineType
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Except
                  {-# LINE 1471 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Except
                  {-# LINE 1476 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 1481 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 1486 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_CombineType_Intersect :: T_CombineType 
sem_CombineType_Intersect  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: CombineType
              _lhsOoriginalTree :: CombineType
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Intersect
                  {-# LINE 1498 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Intersect
                  {-# LINE 1503 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 1508 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 1513 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_CombineType_Union :: T_CombineType 
sem_CombineType_Union  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: CombineType
              _lhsOoriginalTree :: CombineType
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Union
                  {-# LINE 1525 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Union
                  {-# LINE 1530 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 1535 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 1540 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_CombineType_UnionAll :: T_CombineType 
sem_CombineType_UnionAll  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: CombineType
              _lhsOoriginalTree :: CombineType
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  UnionAll
                  {-# LINE 1552 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  UnionAll
                  {-# LINE 1557 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 1562 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 1567 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- Constraint --------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative CheckConstraint:
         child ann            : {Annotation}
         child name           : {String}
         child expression     : Expression 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative PrimaryKeyConstraint:
         child ann            : {Annotation}
         child name           : {String}
         child stringList     : StringList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative ReferenceConstraint:
         child ann            : {Annotation}
         child name           : {String}
         child atts           : StringList 
         child table          : {String}
         child tableAtts      : StringList 
         child onUpdate       : Cascade 
         child onDelete       : Cascade 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative UniqueConstraint:
         child ann            : {Annotation}
         child name           : {String}
         child stringList     : StringList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data Constraint  = CheckConstraint (Annotation) (String) (Expression) 
                 | PrimaryKeyConstraint (Annotation) (String) (StringList) 
                 | ReferenceConstraint (Annotation) (String) (StringList) (String) (StringList) (Cascade) (Cascade) 
                 | UniqueConstraint (Annotation) (String) (StringList) 
                 deriving ( Data,Eq,Show,Typeable)
-- cata
sem_Constraint :: Constraint  ->
                  T_Constraint 
sem_Constraint (CheckConstraint _ann _name _expression )  =
    (sem_Constraint_CheckConstraint _ann _name (sem_Expression _expression ) )
sem_Constraint (PrimaryKeyConstraint _ann _name _stringList )  =
    (sem_Constraint_PrimaryKeyConstraint _ann _name (sem_StringList _stringList ) )
sem_Constraint (ReferenceConstraint _ann _name _atts _table _tableAtts _onUpdate _onDelete )  =
    (sem_Constraint_ReferenceConstraint _ann _name (sem_StringList _atts ) _table (sem_StringList _tableAtts ) (sem_Cascade _onUpdate ) (sem_Cascade _onDelete ) )
sem_Constraint (UniqueConstraint _ann _name _stringList )  =
    (sem_Constraint_UniqueConstraint _ann _name (sem_StringList _stringList ) )
-- semantic domain
type T_Constraint  = Catalog ->
                     LocalBindings ->
                     ( Constraint,Constraint)
data Inh_Constraint  = Inh_Constraint {cat_Inh_Constraint :: Catalog,lib_Inh_Constraint :: LocalBindings}
data Syn_Constraint  = Syn_Constraint {annotatedTree_Syn_Constraint :: Constraint,originalTree_Syn_Constraint :: Constraint}
wrap_Constraint :: T_Constraint  ->
                   Inh_Constraint  ->
                   Syn_Constraint 
wrap_Constraint sem (Inh_Constraint _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_Constraint _lhsOannotatedTree _lhsOoriginalTree ))
sem_Constraint_CheckConstraint :: Annotation ->
                                  String ->
                                  T_Expression  ->
                                  T_Constraint 
sem_Constraint_CheckConstraint ann_ name_ expression_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Constraint
              _lhsOoriginalTree :: Constraint
              _expressionOcat :: Catalog
              _expressionOlib :: LocalBindings
              _expressionIannotatedTree :: Expression
              _expressionIliftedColumnName :: String
              _expressionIoriginalTree :: Expression
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  CheckConstraint ann_ name_ _expressionIannotatedTree
                  {-# LINE 1659 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  CheckConstraint ann_ name_ _expressionIoriginalTree
                  {-# LINE 1664 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 1669 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 1674 "AstInternal.hs" #-}
              -- copy rule (down)
              _expressionOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 1679 "AstInternal.hs" #-}
              -- copy rule (down)
              _expressionOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 1684 "AstInternal.hs" #-}
              ( _expressionIannotatedTree,_expressionIliftedColumnName,_expressionIoriginalTree) =
                  (expression_ _expressionOcat _expressionOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_Constraint_PrimaryKeyConstraint :: Annotation ->
                                       String ->
                                       T_StringList  ->
                                       T_Constraint 
sem_Constraint_PrimaryKeyConstraint ann_ name_ stringList_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Constraint
              _lhsOoriginalTree :: Constraint
              _stringListOcat :: Catalog
              _stringListOlib :: LocalBindings
              _stringListIannotatedTree :: StringList
              _stringListIoriginalTree :: StringList
              _stringListIstrings :: ([String])
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  PrimaryKeyConstraint ann_ name_ _stringListIannotatedTree
                  {-# LINE 1706 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  PrimaryKeyConstraint ann_ name_ _stringListIoriginalTree
                  {-# LINE 1711 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 1716 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 1721 "AstInternal.hs" #-}
              -- copy rule (down)
              _stringListOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 1726 "AstInternal.hs" #-}
              -- copy rule (down)
              _stringListOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 1731 "AstInternal.hs" #-}
              ( _stringListIannotatedTree,_stringListIoriginalTree,_stringListIstrings) =
                  (stringList_ _stringListOcat _stringListOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_Constraint_ReferenceConstraint :: Annotation ->
                                      String ->
                                      T_StringList  ->
                                      String ->
                                      T_StringList  ->
                                      T_Cascade  ->
                                      T_Cascade  ->
                                      T_Constraint 
sem_Constraint_ReferenceConstraint ann_ name_ atts_ table_ tableAtts_ onUpdate_ onDelete_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Constraint
              _lhsOoriginalTree :: Constraint
              _attsOcat :: Catalog
              _attsOlib :: LocalBindings
              _tableAttsOcat :: Catalog
              _tableAttsOlib :: LocalBindings
              _onUpdateOcat :: Catalog
              _onUpdateOlib :: LocalBindings
              _onDeleteOcat :: Catalog
              _onDeleteOlib :: LocalBindings
              _attsIannotatedTree :: StringList
              _attsIoriginalTree :: StringList
              _attsIstrings :: ([String])
              _tableAttsIannotatedTree :: StringList
              _tableAttsIoriginalTree :: StringList
              _tableAttsIstrings :: ([String])
              _onUpdateIannotatedTree :: Cascade
              _onUpdateIoriginalTree :: Cascade
              _onDeleteIannotatedTree :: Cascade
              _onDeleteIoriginalTree :: Cascade
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  ReferenceConstraint ann_ name_ _attsIannotatedTree table_ _tableAttsIannotatedTree _onUpdateIannotatedTree _onDeleteIannotatedTree
                  {-# LINE 1770 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  ReferenceConstraint ann_ name_ _attsIoriginalTree table_ _tableAttsIoriginalTree _onUpdateIoriginalTree _onDeleteIoriginalTree
                  {-# LINE 1775 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 1780 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 1785 "AstInternal.hs" #-}
              -- copy rule (down)
              _attsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 1790 "AstInternal.hs" #-}
              -- copy rule (down)
              _attsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 1795 "AstInternal.hs" #-}
              -- copy rule (down)
              _tableAttsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 1800 "AstInternal.hs" #-}
              -- copy rule (down)
              _tableAttsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 1805 "AstInternal.hs" #-}
              -- copy rule (down)
              _onUpdateOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 1810 "AstInternal.hs" #-}
              -- copy rule (down)
              _onUpdateOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 1815 "AstInternal.hs" #-}
              -- copy rule (down)
              _onDeleteOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 1820 "AstInternal.hs" #-}
              -- copy rule (down)
              _onDeleteOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 1825 "AstInternal.hs" #-}
              ( _attsIannotatedTree,_attsIoriginalTree,_attsIstrings) =
                  (atts_ _attsOcat _attsOlib )
              ( _tableAttsIannotatedTree,_tableAttsIoriginalTree,_tableAttsIstrings) =
                  (tableAtts_ _tableAttsOcat _tableAttsOlib )
              ( _onUpdateIannotatedTree,_onUpdateIoriginalTree) =
                  (onUpdate_ _onUpdateOcat _onUpdateOlib )
              ( _onDeleteIannotatedTree,_onDeleteIoriginalTree) =
                  (onDelete_ _onDeleteOcat _onDeleteOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_Constraint_UniqueConstraint :: Annotation ->
                                   String ->
                                   T_StringList  ->
                                   T_Constraint 
sem_Constraint_UniqueConstraint ann_ name_ stringList_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Constraint
              _lhsOoriginalTree :: Constraint
              _stringListOcat :: Catalog
              _stringListOlib :: LocalBindings
              _stringListIannotatedTree :: StringList
              _stringListIoriginalTree :: StringList
              _stringListIstrings :: ([String])
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  UniqueConstraint ann_ name_ _stringListIannotatedTree
                  {-# LINE 1853 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  UniqueConstraint ann_ name_ _stringListIoriginalTree
                  {-# LINE 1858 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 1863 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 1868 "AstInternal.hs" #-}
              -- copy rule (down)
              _stringListOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 1873 "AstInternal.hs" #-}
              -- copy rule (down)
              _stringListOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 1878 "AstInternal.hs" #-}
              ( _stringListIannotatedTree,_stringListIoriginalTree,_stringListIstrings) =
                  (stringList_ _stringListOcat _stringListOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- ConstraintList ----------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Cons:
         child hd             : Constraint 
         child tl             : ConstraintList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type ConstraintList  = [(Constraint)]
-- cata
sem_ConstraintList :: ConstraintList  ->
                      T_ConstraintList 
sem_ConstraintList list  =
    (Prelude.foldr sem_ConstraintList_Cons sem_ConstraintList_Nil (Prelude.map sem_Constraint list) )
-- semantic domain
type T_ConstraintList  = Catalog ->
                         LocalBindings ->
                         ( ConstraintList,ConstraintList)
data Inh_ConstraintList  = Inh_ConstraintList {cat_Inh_ConstraintList :: Catalog,lib_Inh_ConstraintList :: LocalBindings}
data Syn_ConstraintList  = Syn_ConstraintList {annotatedTree_Syn_ConstraintList :: ConstraintList,originalTree_Syn_ConstraintList :: ConstraintList}
wrap_ConstraintList :: T_ConstraintList  ->
                       Inh_ConstraintList  ->
                       Syn_ConstraintList 
wrap_ConstraintList sem (Inh_ConstraintList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_ConstraintList _lhsOannotatedTree _lhsOoriginalTree ))
sem_ConstraintList_Cons :: T_Constraint  ->
                           T_ConstraintList  ->
                           T_ConstraintList 
sem_ConstraintList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: ConstraintList
              _lhsOoriginalTree :: ConstraintList
              _hdOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _hdIannotatedTree :: Constraint
              _hdIoriginalTree :: Constraint
              _tlIannotatedTree :: ConstraintList
              _tlIoriginalTree :: ConstraintList
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 1942 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 1947 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 1952 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 1957 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 1962 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 1967 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 1972 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 1977 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdIoriginalTree) =
                  (hd_ _hdOcat _hdOlib )
              ( _tlIannotatedTree,_tlIoriginalTree) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_ConstraintList_Nil :: T_ConstraintList 
sem_ConstraintList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: ConstraintList
              _lhsOoriginalTree :: ConstraintList
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 1993 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 1998 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 2003 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 2008 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- CopySource --------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative CopyFilename:
         child string         : {String}
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Stdin:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data CopySource  = CopyFilename (String) 
                 | Stdin 
                 deriving ( Data,Eq,Show,Typeable)
-- cata
sem_CopySource :: CopySource  ->
                  T_CopySource 
sem_CopySource (CopyFilename _string )  =
    (sem_CopySource_CopyFilename _string )
sem_CopySource (Stdin )  =
    (sem_CopySource_Stdin )
-- semantic domain
type T_CopySource  = Catalog ->
                     LocalBindings ->
                     ( CopySource,CopySource)
data Inh_CopySource  = Inh_CopySource {cat_Inh_CopySource :: Catalog,lib_Inh_CopySource :: LocalBindings}
data Syn_CopySource  = Syn_CopySource {annotatedTree_Syn_CopySource :: CopySource,originalTree_Syn_CopySource :: CopySource}
wrap_CopySource :: T_CopySource  ->
                   Inh_CopySource  ->
                   Syn_CopySource 
wrap_CopySource sem (Inh_CopySource _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_CopySource _lhsOannotatedTree _lhsOoriginalTree ))
sem_CopySource_CopyFilename :: String ->
                               T_CopySource 
sem_CopySource_CopyFilename string_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: CopySource
              _lhsOoriginalTree :: CopySource
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  CopyFilename string_
                  {-# LINE 2064 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  CopyFilename string_
                  {-# LINE 2069 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 2074 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 2079 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_CopySource_Stdin :: T_CopySource 
sem_CopySource_Stdin  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: CopySource
              _lhsOoriginalTree :: CopySource
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Stdin
                  {-# LINE 2091 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Stdin
                  {-# LINE 2096 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 2101 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 2106 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- Direction ---------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Asc:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Desc:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data Direction  = Asc 
                | Desc 
                deriving ( Data,Eq,Show,Typeable)
-- cata
sem_Direction :: Direction  ->
                 T_Direction 
sem_Direction (Asc )  =
    (sem_Direction_Asc )
sem_Direction (Desc )  =
    (sem_Direction_Desc )
-- semantic domain
type T_Direction  = Catalog ->
                    LocalBindings ->
                    ( Direction,Direction)
data Inh_Direction  = Inh_Direction {cat_Inh_Direction :: Catalog,lib_Inh_Direction :: LocalBindings}
data Syn_Direction  = Syn_Direction {annotatedTree_Syn_Direction :: Direction,originalTree_Syn_Direction :: Direction}
wrap_Direction :: T_Direction  ->
                  Inh_Direction  ->
                  Syn_Direction 
wrap_Direction sem (Inh_Direction _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_Direction _lhsOannotatedTree _lhsOoriginalTree ))
sem_Direction_Asc :: T_Direction 
sem_Direction_Asc  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Direction
              _lhsOoriginalTree :: Direction
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Asc
                  {-# LINE 2160 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Asc
                  {-# LINE 2165 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 2170 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 2175 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_Direction_Desc :: T_Direction 
sem_Direction_Desc  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Direction
              _lhsOoriginalTree :: Direction
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Desc
                  {-# LINE 2187 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Desc
                  {-# LINE 2192 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 2197 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 2202 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- Distinct ----------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Distinct:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Dupes:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data Distinct  = Distinct 
               | Dupes 
               deriving ( Data,Eq,Show,Typeable)
-- cata
sem_Distinct :: Distinct  ->
                T_Distinct 
sem_Distinct (Distinct )  =
    (sem_Distinct_Distinct )
sem_Distinct (Dupes )  =
    (sem_Distinct_Dupes )
-- semantic domain
type T_Distinct  = Catalog ->
                   LocalBindings ->
                   ( Distinct,Distinct)
data Inh_Distinct  = Inh_Distinct {cat_Inh_Distinct :: Catalog,lib_Inh_Distinct :: LocalBindings}
data Syn_Distinct  = Syn_Distinct {annotatedTree_Syn_Distinct :: Distinct,originalTree_Syn_Distinct :: Distinct}
wrap_Distinct :: T_Distinct  ->
                 Inh_Distinct  ->
                 Syn_Distinct 
wrap_Distinct sem (Inh_Distinct _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_Distinct _lhsOannotatedTree _lhsOoriginalTree ))
sem_Distinct_Distinct :: T_Distinct 
sem_Distinct_Distinct  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Distinct
              _lhsOoriginalTree :: Distinct
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Distinct
                  {-# LINE 2256 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Distinct
                  {-# LINE 2261 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 2266 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 2271 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_Distinct_Dupes :: T_Distinct 
sem_Distinct_Dupes  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Distinct
              _lhsOoriginalTree :: Distinct
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Dupes
                  {-# LINE 2283 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Dupes
                  {-# LINE 2288 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 2293 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 2298 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- DropType ----------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Domain:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Table:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Type:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative View:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data DropType  = Domain 
               | Table 
               | Type 
               | View 
               deriving ( Data,Eq,Show,Typeable)
-- cata
sem_DropType :: DropType  ->
                T_DropType 
sem_DropType (Domain )  =
    (sem_DropType_Domain )
sem_DropType (Table )  =
    (sem_DropType_Table )
sem_DropType (Type )  =
    (sem_DropType_Type )
sem_DropType (View )  =
    (sem_DropType_View )
-- semantic domain
type T_DropType  = Catalog ->
                   LocalBindings ->
                   ( DropType,DropType)
data Inh_DropType  = Inh_DropType {cat_Inh_DropType :: Catalog,lib_Inh_DropType :: LocalBindings}
data Syn_DropType  = Syn_DropType {annotatedTree_Syn_DropType :: DropType,originalTree_Syn_DropType :: DropType}
wrap_DropType :: T_DropType  ->
                 Inh_DropType  ->
                 Syn_DropType 
wrap_DropType sem (Inh_DropType _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_DropType _lhsOannotatedTree _lhsOoriginalTree ))
sem_DropType_Domain :: T_DropType 
sem_DropType_Domain  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: DropType
              _lhsOoriginalTree :: DropType
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Domain
                  {-# LINE 2366 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Domain
                  {-# LINE 2371 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 2376 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 2381 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_DropType_Table :: T_DropType 
sem_DropType_Table  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: DropType
              _lhsOoriginalTree :: DropType
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Table
                  {-# LINE 2393 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Table
                  {-# LINE 2398 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 2403 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 2408 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_DropType_Type :: T_DropType 
sem_DropType_Type  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: DropType
              _lhsOoriginalTree :: DropType
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Type
                  {-# LINE 2420 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Type
                  {-# LINE 2425 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 2430 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 2435 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_DropType_View :: T_DropType 
sem_DropType_View  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: DropType
              _lhsOoriginalTree :: DropType
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  View
                  {-# LINE 2447 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  View
                  {-# LINE 2452 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 2457 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 2462 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- Expression --------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         liftedColumnName     : String
         originalTree         : SELF 
   alternatives:
      alternative BooleanLit:
         child ann            : {Annotation}
         child b              : {Bool}
         visit 0:
            local prototype   : {Maybe FunctionPrototype}
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative Case:
         child ann            : {Annotation}
         child cases          : CaseExpressionListExpressionPairList 
         child els            : MaybeExpression 
         visit 0:
            local prototype   : {Maybe FunctionPrototype}
            local whenTypes   : _
            local thenTypes   : _
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative CaseSimple:
         child ann            : {Annotation}
         child value          : Expression 
         child cases          : CaseExpressionListExpressionPairList 
         child els            : MaybeExpression 
         visit 0:
            local prototype   : {Maybe FunctionPrototype}
            local whenTypes   : _
            local thenTypes   : _
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative Cast:
         child ann            : {Annotation}
         child expr           : Expression 
         child tn             : TypeName 
         visit 0:
            local prototype   : {Maybe FunctionPrototype}
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative Exists:
         child ann            : {Annotation}
         child sel            : SelectExpression 
         visit 0:
            local prototype   : {Maybe FunctionPrototype}
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative FloatLit:
         child ann            : {Annotation}
         child d              : {Double}
         visit 0:
            local prototype   : {Maybe FunctionPrototype}
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative FunCall:
         child ann            : {Annotation}
         child funName        : {String}
         child args           : ExpressionList 
         visit 0:
            local _tup1       : _
            local tpe         : _
            local prototype   : {Maybe FunctionPrototype}
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative Identifier:
         child ann            : {Annotation}
         child i              : {String}
         visit 0:
            local prototype   : {Maybe FunctionPrototype}
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative InPredicate:
         child ann            : {Annotation}
         child expr           : Expression 
         child i              : {Bool}
         child list           : InList 
         visit 0:
            local prototype   : {Maybe FunctionPrototype}
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative IntegerLit:
         child ann            : {Annotation}
         child i              : {Integer}
         visit 0:
            local prototype   : {Maybe FunctionPrototype}
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative LiftOperator:
         child ann            : {Annotation}
         child oper           : {String}
         child flav           : LiftFlavour 
         child args           : ExpressionList 
         visit 0:
            local prototype   : {Maybe FunctionPrototype}
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative NullLit:
         child ann            : {Annotation}
         visit 0:
            local prototype   : {Maybe FunctionPrototype}
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative Placeholder:
         child ann            : {Annotation}
         visit 0:
            local prototype   : {Maybe FunctionPrototype}
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative PositionalArg:
         child ann            : {Annotation}
         child p              : {Integer}
         visit 0:
            local prototype   : {Maybe FunctionPrototype}
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative ScalarSubQuery:
         child ann            : {Annotation}
         child sel            : SelectExpression 
         visit 0:
            local prototype   : {Maybe FunctionPrototype}
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative StringLit:
         child ann            : {Annotation}
         child quote          : {String}
         child value          : {String}
         visit 0:
            local prototype   : {Maybe FunctionPrototype}
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative WindowFn:
         child ann            : {Annotation}
         child fn             : Expression 
         child partitionBy    : ExpressionList 
         child orderBy        : ExpressionList 
         child dir            : Direction 
         child frm            : FrameClause 
         visit 0:
            local prototype   : {Maybe FunctionPrototype}
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
-}
data Expression  = BooleanLit (Annotation) (Bool) 
                 | Case (Annotation) (CaseExpressionListExpressionPairList) (MaybeExpression) 
                 | CaseSimple (Annotation) (Expression) (CaseExpressionListExpressionPairList) (MaybeExpression) 
                 | Cast (Annotation) (Expression) (TypeName) 
                 | Exists (Annotation) (SelectExpression) 
                 | FloatLit (Annotation) (Double) 
                 | FunCall (Annotation) (String) (ExpressionList) 
                 | Identifier (Annotation) (String) 
                 | InPredicate (Annotation) (Expression) (Bool) (InList) 
                 | IntegerLit (Annotation) (Integer) 
                 | LiftOperator (Annotation) (String) (LiftFlavour) (ExpressionList) 
                 | NullLit (Annotation) 
                 | Placeholder (Annotation) 
                 | PositionalArg (Annotation) (Integer) 
                 | ScalarSubQuery (Annotation) (SelectExpression) 
                 | StringLit (Annotation) (String) (String) 
                 | WindowFn (Annotation) (Expression) (ExpressionList) (ExpressionList) (Direction) (FrameClause) 
                 deriving ( Data,Eq,Show,Typeable)
-- cata
sem_Expression :: Expression  ->
                  T_Expression 
sem_Expression (BooleanLit _ann _b )  =
    (sem_Expression_BooleanLit _ann _b )
sem_Expression (Case _ann _cases _els )  =
    (sem_Expression_Case _ann (sem_CaseExpressionListExpressionPairList _cases ) (sem_MaybeExpression _els ) )
sem_Expression (CaseSimple _ann _value _cases _els )  =
    (sem_Expression_CaseSimple _ann (sem_Expression _value ) (sem_CaseExpressionListExpressionPairList _cases ) (sem_MaybeExpression _els ) )
sem_Expression (Cast _ann _expr _tn )  =
    (sem_Expression_Cast _ann (sem_Expression _expr ) (sem_TypeName _tn ) )
sem_Expression (Exists _ann _sel )  =
    (sem_Expression_Exists _ann (sem_SelectExpression _sel ) )
sem_Expression (FloatLit _ann _d )  =
    (sem_Expression_FloatLit _ann _d )
sem_Expression (FunCall _ann _funName _args )  =
    (sem_Expression_FunCall _ann _funName (sem_ExpressionList _args ) )
sem_Expression (Identifier _ann _i )  =
    (sem_Expression_Identifier _ann _i )
sem_Expression (InPredicate _ann _expr _i _list )  =
    (sem_Expression_InPredicate _ann (sem_Expression _expr ) _i (sem_InList _list ) )
sem_Expression (IntegerLit _ann _i )  =
    (sem_Expression_IntegerLit _ann _i )
sem_Expression (LiftOperator _ann _oper _flav _args )  =
    (sem_Expression_LiftOperator _ann _oper (sem_LiftFlavour _flav ) (sem_ExpressionList _args ) )
sem_Expression (NullLit _ann )  =
    (sem_Expression_NullLit _ann )
sem_Expression (Placeholder _ann )  =
    (sem_Expression_Placeholder _ann )
sem_Expression (PositionalArg _ann _p )  =
    (sem_Expression_PositionalArg _ann _p )
sem_Expression (ScalarSubQuery _ann _sel )  =
    (sem_Expression_ScalarSubQuery _ann (sem_SelectExpression _sel ) )
sem_Expression (StringLit _ann _quote _value )  =
    (sem_Expression_StringLit _ann _quote _value )
sem_Expression (WindowFn _ann _fn _partitionBy _orderBy _dir _frm )  =
    (sem_Expression_WindowFn _ann (sem_Expression _fn ) (sem_ExpressionList _partitionBy ) (sem_ExpressionList _orderBy ) (sem_Direction _dir ) (sem_FrameClause _frm ) )
-- semantic domain
type T_Expression  = Catalog ->
                     LocalBindings ->
                     ( Expression,String,Expression)
data Inh_Expression  = Inh_Expression {cat_Inh_Expression :: Catalog,lib_Inh_Expression :: LocalBindings}
data Syn_Expression  = Syn_Expression {annotatedTree_Syn_Expression :: Expression,liftedColumnName_Syn_Expression :: String,originalTree_Syn_Expression :: Expression}
wrap_Expression :: T_Expression  ->
                   Inh_Expression  ->
                   Syn_Expression 
wrap_Expression sem (Inh_Expression _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOliftedColumnName,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_Expression _lhsOannotatedTree _lhsOliftedColumnName _lhsOoriginalTree ))
sem_Expression_BooleanLit :: Annotation ->
                             Bool ->
                             T_Expression 
sem_Expression_BooleanLit ann_ b_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Expression
              _prototype :: (Maybe FunctionPrototype)
              _lhsOliftedColumnName :: String
              _lhsOoriginalTree :: Expression
              -- "./TypeChecking/Expressions.ag"(line 14, column 9)
              _lhsOannotatedTree =
                  {-# LINE 14 "./TypeChecking/Expressions.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ fmap ((:[]) . FunctionPrototypeA) _prototype
                  {-# LINE 2731 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 29, column 9)
              _prototype =
                  {-# LINE 29 "./TypeChecking/Expressions.ag" #-}
                  Nothing
                  {-# LINE 2736 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 41, column 19)
              _tpe =
                  {-# LINE 41 "./TypeChecking/Expressions.ag" #-}
                  Right typeBool
                  {-# LINE 2741 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 53, column 9)
              _backTree =
                  {-# LINE 53 "./TypeChecking/Expressions.ag" #-}
                  BooleanLit ann_ b_
                  {-# LINE 2746 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 178, column 7)
              _lhsOliftedColumnName =
                  {-# LINE 178 "./TypeChecking/SelectLists.ag" #-}
                  ""
                  {-# LINE 2751 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  BooleanLit ann_ b_
                  {-# LINE 2756 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  BooleanLit ann_ b_
                  {-# LINE 2761 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 2766 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOliftedColumnName,_lhsOoriginalTree)))
sem_Expression_Case :: Annotation ->
                       T_CaseExpressionListExpressionPairList  ->
                       T_MaybeExpression  ->
                       T_Expression 
sem_Expression_Case ann_ cases_ els_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Expression
              _prototype :: (Maybe FunctionPrototype)
              _lhsOliftedColumnName :: String
              _lhsOoriginalTree :: Expression
              _casesOcat :: Catalog
              _casesOlib :: LocalBindings
              _elsOcat :: Catalog
              _elsOlib :: LocalBindings
              _casesIannotatedTree :: CaseExpressionListExpressionPairList
              _casesIoriginalTree :: CaseExpressionListExpressionPairList
              _elsIannotatedTree :: MaybeExpression
              _elsIoriginalTree :: MaybeExpression
              -- "./TypeChecking/Expressions.ag"(line 14, column 9)
              _lhsOannotatedTree =
                  {-# LINE 14 "./TypeChecking/Expressions.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ fmap ((:[]) . FunctionPrototypeA) _prototype
                  {-# LINE 2794 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 29, column 9)
              _prototype =
                  {-# LINE 29 "./TypeChecking/Expressions.ag" #-}
                  Nothing
                  {-# LINE 2799 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 202, column 9)
              _whenTypes =
                  {-# LINE 202 "./TypeChecking/Expressions.ag" #-}
                  map getTypeAnnotation $ concatMap fst $
                  _casesIannotatedTree
                  {-# LINE 2805 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 204, column 9)
              _thenTypes =
                  {-# LINE 204 "./TypeChecking/Expressions.ag" #-}
                  map getTypeAnnotation $
                      (map snd $ _casesIannotatedTree) ++
                        maybeToList _elsIannotatedTree
                  {-# LINE 2812 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 210, column 9)
              _tpe =
                  {-# LINE 210 "./TypeChecking/Expressions.ag" #-}
                  dependsOnRTpe _whenTypes     $ do
                  errorWhen (any (/= typeBool) _whenTypes    ) $
                            [WrongTypes typeBool _whenTypes    ]
                  dependsOnRTpe _thenTypes     $
                    resolveResultSetType _lhsIcat _thenTypes
                  {-# LINE 2821 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 216, column 9)
              _backTree =
                  {-# LINE 216 "./TypeChecking/Expressions.ag" #-}
                  Case ann_ _casesIannotatedTree _elsIannotatedTree
                  {-# LINE 2826 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 178, column 7)
              _lhsOliftedColumnName =
                  {-# LINE 178 "./TypeChecking/SelectLists.ag" #-}
                  ""
                  {-# LINE 2831 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Case ann_ _casesIannotatedTree _elsIannotatedTree
                  {-# LINE 2836 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Case ann_ _casesIoriginalTree _elsIoriginalTree
                  {-# LINE 2841 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 2846 "AstInternal.hs" #-}
              -- copy rule (down)
              _casesOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 2851 "AstInternal.hs" #-}
              -- copy rule (down)
              _casesOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 2856 "AstInternal.hs" #-}
              -- copy rule (down)
              _elsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 2861 "AstInternal.hs" #-}
              -- copy rule (down)
              _elsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 2866 "AstInternal.hs" #-}
              ( _casesIannotatedTree,_casesIoriginalTree) =
                  (cases_ _casesOcat _casesOlib )
              ( _elsIannotatedTree,_elsIoriginalTree) =
                  (els_ _elsOcat _elsOlib )
          in  ( _lhsOannotatedTree,_lhsOliftedColumnName,_lhsOoriginalTree)))
sem_Expression_CaseSimple :: Annotation ->
                             T_Expression  ->
                             T_CaseExpressionListExpressionPairList  ->
                             T_MaybeExpression  ->
                             T_Expression 
sem_Expression_CaseSimple ann_ value_ cases_ els_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Expression
              _prototype :: (Maybe FunctionPrototype)
              _lhsOoriginalTree :: Expression
              _lhsOliftedColumnName :: String
              _valueOcat :: Catalog
              _valueOlib :: LocalBindings
              _casesOcat :: Catalog
              _casesOlib :: LocalBindings
              _elsOcat :: Catalog
              _elsOlib :: LocalBindings
              _valueIannotatedTree :: Expression
              _valueIliftedColumnName :: String
              _valueIoriginalTree :: Expression
              _casesIannotatedTree :: CaseExpressionListExpressionPairList
              _casesIoriginalTree :: CaseExpressionListExpressionPairList
              _elsIannotatedTree :: MaybeExpression
              _elsIoriginalTree :: MaybeExpression
              -- "./TypeChecking/Expressions.ag"(line 14, column 9)
              _lhsOannotatedTree =
                  {-# LINE 14 "./TypeChecking/Expressions.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ fmap ((:[]) . FunctionPrototypeA) _prototype
                  {-# LINE 2904 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 29, column 9)
              _prototype =
                  {-# LINE 29 "./TypeChecking/Expressions.ag" #-}
                  Nothing
                  {-# LINE 2909 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 202, column 9)
              _whenTypes =
                  {-# LINE 202 "./TypeChecking/Expressions.ag" #-}
                  map getTypeAnnotation $ concatMap fst $
                  _casesIannotatedTree
                  {-# LINE 2915 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 204, column 9)
              _thenTypes =
                  {-# LINE 204 "./TypeChecking/Expressions.ag" #-}
                  map getTypeAnnotation $
                      (map snd $ _casesIannotatedTree) ++
                        maybeToList _elsIannotatedTree
                  {-# LINE 2922 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 221, column 9)
              _tpe =
                  {-# LINE 221 "./TypeChecking/Expressions.ag" #-}
                  dependsOnRTpe _whenTypes     $ do
                  let valueType = getTypeAnnotation _valueIannotatedTree
                  checkWhenTypes <-
                      resolveResultSetType _lhsIcat (valueType : _whenTypes    )
                  dependsOnRTpe _thenTypes     $
                    resolveResultSetType _lhsIcat _thenTypes
                  {-# LINE 2932 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 228, column 9)
              _backTree =
                  {-# LINE 228 "./TypeChecking/Expressions.ag" #-}
                  CaseSimple ann_
                             _valueIannotatedTree
                             _casesIannotatedTree
                             _elsIannotatedTree
                  {-# LINE 2940 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  CaseSimple ann_ _valueIannotatedTree _casesIannotatedTree _elsIannotatedTree
                  {-# LINE 2945 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  CaseSimple ann_ _valueIoriginalTree _casesIoriginalTree _elsIoriginalTree
                  {-# LINE 2950 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 2955 "AstInternal.hs" #-}
              -- copy rule (up)
              _lhsOliftedColumnName =
                  {-# LINE 162 "./TypeChecking/SelectLists.ag" #-}
                  _valueIliftedColumnName
                  {-# LINE 2960 "AstInternal.hs" #-}
              -- copy rule (down)
              _valueOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 2965 "AstInternal.hs" #-}
              -- copy rule (down)
              _valueOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 2970 "AstInternal.hs" #-}
              -- copy rule (down)
              _casesOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 2975 "AstInternal.hs" #-}
              -- copy rule (down)
              _casesOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 2980 "AstInternal.hs" #-}
              -- copy rule (down)
              _elsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 2985 "AstInternal.hs" #-}
              -- copy rule (down)
              _elsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 2990 "AstInternal.hs" #-}
              ( _valueIannotatedTree,_valueIliftedColumnName,_valueIoriginalTree) =
                  (value_ _valueOcat _valueOlib )
              ( _casesIannotatedTree,_casesIoriginalTree) =
                  (cases_ _casesOcat _casesOlib )
              ( _elsIannotatedTree,_elsIoriginalTree) =
                  (els_ _elsOcat _elsOlib )
          in  ( _lhsOannotatedTree,_lhsOliftedColumnName,_lhsOoriginalTree)))
sem_Expression_Cast :: Annotation ->
                       T_Expression  ->
                       T_TypeName  ->
                       T_Expression 
sem_Expression_Cast ann_ expr_ tn_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Expression
              _prototype :: (Maybe FunctionPrototype)
              _lhsOliftedColumnName :: String
              _lhsOoriginalTree :: Expression
              _exprOcat :: Catalog
              _exprOlib :: LocalBindings
              _tnOcat :: Catalog
              _tnOlib :: LocalBindings
              _exprIannotatedTree :: Expression
              _exprIliftedColumnName :: String
              _exprIoriginalTree :: Expression
              _tnIannotatedTree :: TypeName
              _tnInamedType :: Type
              _tnIoriginalTree :: TypeName
              -- "./TypeChecking/Expressions.ag"(line 14, column 9)
              _lhsOannotatedTree =
                  {-# LINE 14 "./TypeChecking/Expressions.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ fmap ((:[]) . FunctionPrototypeA) _prototype
                  {-# LINE 3026 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 29, column 9)
              _prototype =
                  {-# LINE 29 "./TypeChecking/Expressions.ag" #-}
                  Nothing
                  {-# LINE 3031 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 66, column 12)
              _tpe =
                  {-# LINE 66 "./TypeChecking/Expressions.ag" #-}
                  Right $ _tnInamedType
                  {-# LINE 3036 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 67, column 12)
              _backTree =
                  {-# LINE 67 "./TypeChecking/Expressions.ag" #-}
                  Cast ann_ _exprIannotatedTree _tnIannotatedTree
                  {-# LINE 3041 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 170, column 10)
              _lhsOliftedColumnName =
                  {-# LINE 170 "./TypeChecking/SelectLists.ag" #-}
                  case _tnIannotatedTree of
                    SimpleTypeName _ tn -> tn
                    _ -> ""
                  {-# LINE 3048 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Cast ann_ _exprIannotatedTree _tnIannotatedTree
                  {-# LINE 3053 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Cast ann_ _exprIoriginalTree _tnIoriginalTree
                  {-# LINE 3058 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 3063 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 3068 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 3073 "AstInternal.hs" #-}
              -- copy rule (down)
              _tnOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 3078 "AstInternal.hs" #-}
              -- copy rule (down)
              _tnOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 3083 "AstInternal.hs" #-}
              ( _exprIannotatedTree,_exprIliftedColumnName,_exprIoriginalTree) =
                  (expr_ _exprOcat _exprOlib )
              ( _tnIannotatedTree,_tnInamedType,_tnIoriginalTree) =
                  (tn_ _tnOcat _tnOlib )
          in  ( _lhsOannotatedTree,_lhsOliftedColumnName,_lhsOoriginalTree)))
sem_Expression_Exists :: Annotation ->
                         T_SelectExpression  ->
                         T_Expression 
sem_Expression_Exists ann_ sel_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Expression
              _prototype :: (Maybe FunctionPrototype)
              _lhsOliftedColumnName :: String
              _lhsOoriginalTree :: Expression
              _selOcat :: Catalog
              _selOlib :: LocalBindings
              _selIannotatedTree :: SelectExpression
              _selIlibUpdates :: ([LocalBindingsUpdate])
              _selIoriginalTree :: SelectExpression
              -- "./TypeChecking/Expressions.ag"(line 14, column 9)
              _lhsOannotatedTree =
                  {-# LINE 14 "./TypeChecking/Expressions.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ fmap ((:[]) . FunctionPrototypeA) _prototype
                  {-# LINE 3111 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 29, column 9)
              _prototype =
                  {-# LINE 29 "./TypeChecking/Expressions.ag" #-}
                  Nothing
                  {-# LINE 3116 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 259, column 9)
              _tpe =
                  {-# LINE 259 "./TypeChecking/Expressions.ag" #-}
                  Right typeBool
                  {-# LINE 3121 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 260, column 9)
              _backTree =
                  {-# LINE 260 "./TypeChecking/Expressions.ag" #-}
                  Exists ann_ _selIannotatedTree
                  {-# LINE 3126 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 178, column 7)
              _lhsOliftedColumnName =
                  {-# LINE 178 "./TypeChecking/SelectLists.ag" #-}
                  ""
                  {-# LINE 3131 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Exists ann_ _selIannotatedTree
                  {-# LINE 3136 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Exists ann_ _selIoriginalTree
                  {-# LINE 3141 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 3146 "AstInternal.hs" #-}
              -- copy rule (down)
              _selOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 3151 "AstInternal.hs" #-}
              -- copy rule (down)
              _selOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 3156 "AstInternal.hs" #-}
              ( _selIannotatedTree,_selIlibUpdates,_selIoriginalTree) =
                  (sel_ _selOcat _selOlib )
          in  ( _lhsOannotatedTree,_lhsOliftedColumnName,_lhsOoriginalTree)))
sem_Expression_FloatLit :: Annotation ->
                           Double ->
                           T_Expression 
sem_Expression_FloatLit ann_ d_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Expression
              _prototype :: (Maybe FunctionPrototype)
              _lhsOliftedColumnName :: String
              _lhsOoriginalTree :: Expression
              -- "./TypeChecking/Expressions.ag"(line 14, column 9)
              _lhsOannotatedTree =
                  {-# LINE 14 "./TypeChecking/Expressions.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ fmap ((:[]) . FunctionPrototypeA) _prototype
                  {-# LINE 3177 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 29, column 9)
              _prototype =
                  {-# LINE 29 "./TypeChecking/Expressions.ag" #-}
                  Nothing
                  {-# LINE 3182 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 40, column 17)
              _tpe =
                  {-# LINE 40 "./TypeChecking/Expressions.ag" #-}
                  Right typeNumeric
                  {-# LINE 3187 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 51, column 9)
              _backTree =
                  {-# LINE 51 "./TypeChecking/Expressions.ag" #-}
                  FloatLit ann_ d_
                  {-# LINE 3192 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 178, column 7)
              _lhsOliftedColumnName =
                  {-# LINE 178 "./TypeChecking/SelectLists.ag" #-}
                  ""
                  {-# LINE 3197 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  FloatLit ann_ d_
                  {-# LINE 3202 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  FloatLit ann_ d_
                  {-# LINE 3207 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 3212 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOliftedColumnName,_lhsOoriginalTree)))
sem_Expression_FunCall :: Annotation ->
                          String ->
                          T_ExpressionList  ->
                          T_Expression 
sem_Expression_FunCall ann_ funName_ args_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Expression
              _prototype :: (Maybe FunctionPrototype)
              _lhsOliftedColumnName :: String
              _lhsOoriginalTree :: Expression
              _argsOcat :: Catalog
              _argsOlib :: LocalBindings
              _argsIannotatedTree :: ExpressionList
              _argsIoriginalTree :: ExpressionList
              _argsItypeList :: ([Type])
              -- "./TypeChecking/Expressions.ag"(line 14, column 9)
              _lhsOannotatedTree =
                  {-# LINE 14 "./TypeChecking/Expressions.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ fmap ((:[]) . FunctionPrototypeA) _prototype
                  {-# LINE 3237 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 74, column 9)
              __tup1 =
                  {-# LINE 74 "./TypeChecking/Expressions.ag" #-}
                  if any (==TypeCheckFailed) _argsItypeList
                  then (Right TypeCheckFailed, Nothing)
                  else
                    let fe = typeCheckFunCall
                             _lhsIcat
                             funName_
                             _argsItypeList
                    in (dependsOnRTpe _argsItypeList $ fmap (\(_,_,r,_) -> r) fe
                       ,eitherToMaybe fe)
                  {-# LINE 3250 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 74, column 9)
              (_tpe,_) =
                  {-# LINE 74 "./TypeChecking/Expressions.ag" #-}
                  __tup1
                  {-# LINE 3255 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 74, column 9)
              (_,_prototype) =
                  {-# LINE 74 "./TypeChecking/Expressions.ag" #-}
                  __tup1
                  {-# LINE 3260 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 83, column 9)
              _backTree =
                  {-# LINE 83 "./TypeChecking/Expressions.ag" #-}
                  FunCall ann_ funName_ _argsIannotatedTree
                  {-# LINE 3265 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 166, column 13)
              _lhsOliftedColumnName =
                  {-# LINE 166 "./TypeChecking/SelectLists.ag" #-}
                  if isOperatorName funName_
                     then ""
                     else funName_
                  {-# LINE 3272 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  FunCall ann_ funName_ _argsIannotatedTree
                  {-# LINE 3277 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  FunCall ann_ funName_ _argsIoriginalTree
                  {-# LINE 3282 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 3287 "AstInternal.hs" #-}
              -- copy rule (down)
              _argsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 3292 "AstInternal.hs" #-}
              -- copy rule (down)
              _argsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 3297 "AstInternal.hs" #-}
              ( _argsIannotatedTree,_argsIoriginalTree,_argsItypeList) =
                  (args_ _argsOcat _argsOlib )
          in  ( _lhsOannotatedTree,_lhsOliftedColumnName,_lhsOoriginalTree)))
sem_Expression_Identifier :: Annotation ->
                             String ->
                             T_Expression 
sem_Expression_Identifier ann_ i_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Expression
              _prototype :: (Maybe FunctionPrototype)
              _lhsOliftedColumnName :: String
              _lhsOoriginalTree :: Expression
              -- "./TypeChecking/Expressions.ag"(line 14, column 9)
              _lhsOannotatedTree =
                  {-# LINE 14 "./TypeChecking/Expressions.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ fmap ((:[]) . FunctionPrototypeA) _prototype
                  {-# LINE 3318 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 29, column 9)
              _prototype =
                  {-# LINE 29 "./TypeChecking/Expressions.ag" #-}
                  Nothing
                  {-# LINE 3323 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 241, column 9)
              _tpe =
                  {-# LINE 241 "./TypeChecking/Expressions.ag" #-}
                  lbLookupID _lhsIlib i_
                  {-# LINE 3328 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 242, column 9)
              _backTree =
                  {-# LINE 242 "./TypeChecking/Expressions.ag" #-}
                  Identifier ann_ i_
                  {-# LINE 3333 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 165, column 16)
              _lhsOliftedColumnName =
                  {-# LINE 165 "./TypeChecking/SelectLists.ag" #-}
                  i_
                  {-# LINE 3338 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Identifier ann_ i_
                  {-# LINE 3343 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Identifier ann_ i_
                  {-# LINE 3348 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 3353 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOliftedColumnName,_lhsOoriginalTree)))
sem_Expression_InPredicate :: Annotation ->
                              T_Expression  ->
                              Bool ->
                              T_InList  ->
                              T_Expression 
sem_Expression_InPredicate ann_ expr_ i_ list_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Expression
              _prototype :: (Maybe FunctionPrototype)
              _lhsOoriginalTree :: Expression
              _lhsOliftedColumnName :: String
              _exprOcat :: Catalog
              _exprOlib :: LocalBindings
              _listOcat :: Catalog
              _listOlib :: LocalBindings
              _exprIannotatedTree :: Expression
              _exprIliftedColumnName :: String
              _exprIoriginalTree :: Expression
              _listIannotatedTree :: InList
              _listIlistType :: (Either [TypeError] Type)
              _listIoriginalTree :: InList
              -- "./TypeChecking/Expressions.ag"(line 14, column 9)
              _lhsOannotatedTree =
                  {-# LINE 14 "./TypeChecking/Expressions.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ fmap ((:[]) . FunctionPrototypeA) _prototype
                  {-# LINE 3384 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 29, column 9)
              _prototype =
                  {-# LINE 29 "./TypeChecking/Expressions.ag" #-}
                  Nothing
                  {-# LINE 3389 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 289, column 9)
              _tpe =
                  {-# LINE 289 "./TypeChecking/Expressions.ag" #-}
                  do
                  lt <- _listIlistType
                  ty <- resolveResultSetType
                            _lhsIcat
                            [getTypeAnnotation _exprIannotatedTree, lt]
                  return typeBool
                  {-# LINE 3399 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 295, column 9)
              _backTree =
                  {-# LINE 295 "./TypeChecking/Expressions.ag" #-}
                  InPredicate ann_
                              _exprIannotatedTree
                              i_
                              _listIannotatedTree
                  {-# LINE 3407 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  InPredicate ann_ _exprIannotatedTree i_ _listIannotatedTree
                  {-# LINE 3412 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  InPredicate ann_ _exprIoriginalTree i_ _listIoriginalTree
                  {-# LINE 3417 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 3422 "AstInternal.hs" #-}
              -- copy rule (up)
              _lhsOliftedColumnName =
                  {-# LINE 162 "./TypeChecking/SelectLists.ag" #-}
                  _exprIliftedColumnName
                  {-# LINE 3427 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 3432 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 3437 "AstInternal.hs" #-}
              -- copy rule (down)
              _listOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 3442 "AstInternal.hs" #-}
              -- copy rule (down)
              _listOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 3447 "AstInternal.hs" #-}
              ( _exprIannotatedTree,_exprIliftedColumnName,_exprIoriginalTree) =
                  (expr_ _exprOcat _exprOlib )
              ( _listIannotatedTree,_listIlistType,_listIoriginalTree) =
                  (list_ _listOcat _listOlib )
          in  ( _lhsOannotatedTree,_lhsOliftedColumnName,_lhsOoriginalTree)))
sem_Expression_IntegerLit :: Annotation ->
                             Integer ->
                             T_Expression 
sem_Expression_IntegerLit ann_ i_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Expression
              _prototype :: (Maybe FunctionPrototype)
              _lhsOliftedColumnName :: String
              _lhsOoriginalTree :: Expression
              -- "./TypeChecking/Expressions.ag"(line 14, column 9)
              _lhsOannotatedTree =
                  {-# LINE 14 "./TypeChecking/Expressions.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ fmap ((:[]) . FunctionPrototypeA) _prototype
                  {-# LINE 3470 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 29, column 9)
              _prototype =
                  {-# LINE 29 "./TypeChecking/Expressions.ag" #-}
                  Nothing
                  {-# LINE 3475 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 38, column 19)
              _tpe =
                  {-# LINE 38 "./TypeChecking/Expressions.ag" #-}
                  Right typeInt
                  {-# LINE 3480 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 47, column 9)
              _backTree =
                  {-# LINE 47 "./TypeChecking/Expressions.ag" #-}
                  IntegerLit ann_ i_
                  {-# LINE 3485 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 178, column 7)
              _lhsOliftedColumnName =
                  {-# LINE 178 "./TypeChecking/SelectLists.ag" #-}
                  ""
                  {-# LINE 3490 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  IntegerLit ann_ i_
                  {-# LINE 3495 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  IntegerLit ann_ i_
                  {-# LINE 3500 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 3505 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOliftedColumnName,_lhsOoriginalTree)))
sem_Expression_LiftOperator :: Annotation ->
                               String ->
                               T_LiftFlavour  ->
                               T_ExpressionList  ->
                               T_Expression 
sem_Expression_LiftOperator ann_ oper_ flav_ args_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Expression
              _prototype :: (Maybe FunctionPrototype)
              _lhsOliftedColumnName :: String
              _lhsOoriginalTree :: Expression
              _flavOcat :: Catalog
              _flavOlib :: LocalBindings
              _argsOcat :: Catalog
              _argsOlib :: LocalBindings
              _flavIannotatedTree :: LiftFlavour
              _flavIoriginalTree :: LiftFlavour
              _argsIannotatedTree :: ExpressionList
              _argsIoriginalTree :: ExpressionList
              _argsItypeList :: ([Type])
              -- "./TypeChecking/Expressions.ag"(line 14, column 9)
              _lhsOannotatedTree =
                  {-# LINE 14 "./TypeChecking/Expressions.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ fmap ((:[]) . FunctionPrototypeA) _prototype
                  {-# LINE 3535 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 29, column 9)
              _prototype =
                  {-# LINE 29 "./TypeChecking/Expressions.ag" #-}
                  Nothing
                  {-# LINE 3540 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 167, column 9)
              _tpe =
                  {-# LINE 167 "./TypeChecking/Expressions.ag" #-}
                  dependsOnRTpe _argsItypeList $ do
                  let args = _argsIannotatedTree
                  errorWhen (length args /= 2)
                            [AnyAllError $ "must have two args, got " ++ show args]
                  let [a,b] = args
                      aType = getTypeAnnotation a
                      bType = getTypeAnnotation b
                  dependsOnRTpe [aType,bType] $ do
                  errorWhen (not $ isArrayType bType)
                            [AnyAllError $ "second arg must be array, got " ++ show args]
                  elemType <- unwrapArray $ bType
                  resType <- fmap (\(_,_,r,_) -> r) $ typeCheckFunCall
                                     _lhsIcat
                                     oper_
                                     [aType,elemType]
                  errorWhen (resType /= typeBool)
                            [AnyAllError $ "operator must have bool return, got " ++ show resType]
                  return resType
                  {-# LINE 3562 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 185, column 9)
              _backTree =
                  {-# LINE 185 "./TypeChecking/Expressions.ag" #-}
                  LiftOperator ann_ oper_ _flavIannotatedTree _argsIannotatedTree
                  {-# LINE 3567 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 178, column 7)
              _lhsOliftedColumnName =
                  {-# LINE 178 "./TypeChecking/SelectLists.ag" #-}
                  ""
                  {-# LINE 3572 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  LiftOperator ann_ oper_ _flavIannotatedTree _argsIannotatedTree
                  {-# LINE 3577 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  LiftOperator ann_ oper_ _flavIoriginalTree _argsIoriginalTree
                  {-# LINE 3582 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 3587 "AstInternal.hs" #-}
              -- copy rule (down)
              _flavOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 3592 "AstInternal.hs" #-}
              -- copy rule (down)
              _flavOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 3597 "AstInternal.hs" #-}
              -- copy rule (down)
              _argsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 3602 "AstInternal.hs" #-}
              -- copy rule (down)
              _argsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 3607 "AstInternal.hs" #-}
              ( _flavIannotatedTree,_flavIoriginalTree) =
                  (flav_ _flavOcat _flavOlib )
              ( _argsIannotatedTree,_argsIoriginalTree,_argsItypeList) =
                  (args_ _argsOcat _argsOlib )
          in  ( _lhsOannotatedTree,_lhsOliftedColumnName,_lhsOoriginalTree)))
sem_Expression_NullLit :: Annotation ->
                          T_Expression 
sem_Expression_NullLit ann_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Expression
              _prototype :: (Maybe FunctionPrototype)
              _lhsOliftedColumnName :: String
              _lhsOoriginalTree :: Expression
              -- "./TypeChecking/Expressions.ag"(line 14, column 9)
              _lhsOannotatedTree =
                  {-# LINE 14 "./TypeChecking/Expressions.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ fmap ((:[]) . FunctionPrototypeA) _prototype
                  {-# LINE 3629 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 29, column 9)
              _prototype =
                  {-# LINE 29 "./TypeChecking/Expressions.ag" #-}
                  Nothing
                  {-# LINE 3634 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 43, column 16)
              _tpe =
                  {-# LINE 43 "./TypeChecking/Expressions.ag" #-}
                  Right UnknownType
                  {-# LINE 3639 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 55, column 9)
              _backTree =
                  {-# LINE 55 "./TypeChecking/Expressions.ag" #-}
                  NullLit ann_
                  {-# LINE 3644 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 178, column 7)
              _lhsOliftedColumnName =
                  {-# LINE 178 "./TypeChecking/SelectLists.ag" #-}
                  ""
                  {-# LINE 3649 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  NullLit ann_
                  {-# LINE 3654 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  NullLit ann_
                  {-# LINE 3659 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 3664 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOliftedColumnName,_lhsOoriginalTree)))
sem_Expression_Placeholder :: Annotation ->
                              T_Expression 
sem_Expression_Placeholder ann_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Expression
              _prototype :: (Maybe FunctionPrototype)
              _lhsOliftedColumnName :: String
              _lhsOoriginalTree :: Expression
              -- "./TypeChecking/Expressions.ag"(line 14, column 9)
              _lhsOannotatedTree =
                  {-# LINE 14 "./TypeChecking/Expressions.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ fmap ((:[]) . FunctionPrototypeA) _prototype
                  {-# LINE 3682 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 29, column 9)
              _prototype =
                  {-# LINE 29 "./TypeChecking/Expressions.ag" #-}
                  Nothing
                  {-# LINE 3687 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 253, column 9)
              _tpe =
                  {-# LINE 253 "./TypeChecking/Expressions.ag" #-}
                  Right UnknownType
                  {-# LINE 3692 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 254, column 9)
              _backTree =
                  {-# LINE 254 "./TypeChecking/Expressions.ag" #-}
                  Placeholder ann_
                  {-# LINE 3697 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 178, column 7)
              _lhsOliftedColumnName =
                  {-# LINE 178 "./TypeChecking/SelectLists.ag" #-}
                  ""
                  {-# LINE 3702 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Placeholder ann_
                  {-# LINE 3707 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Placeholder ann_
                  {-# LINE 3712 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 3717 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOliftedColumnName,_lhsOoriginalTree)))
sem_Expression_PositionalArg :: Annotation ->
                                Integer ->
                                T_Expression 
sem_Expression_PositionalArg ann_ p_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Expression
              _prototype :: (Maybe FunctionPrototype)
              _lhsOliftedColumnName :: String
              _lhsOoriginalTree :: Expression
              -- "./TypeChecking/Expressions.ag"(line 14, column 9)
              _lhsOannotatedTree =
                  {-# LINE 14 "./TypeChecking/Expressions.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ fmap ((:[]) . FunctionPrototypeA) _prototype
                  {-# LINE 3736 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 29, column 9)
              _prototype =
                  {-# LINE 29 "./TypeChecking/Expressions.ag" #-}
                  Nothing
                  {-# LINE 3741 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 247, column 9)
              _tpe =
                  {-# LINE 247 "./TypeChecking/Expressions.ag" #-}
                  lbLookupID _lhsIlib ('$':show p_)
                  {-# LINE 3746 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 248, column 9)
              _backTree =
                  {-# LINE 248 "./TypeChecking/Expressions.ag" #-}
                  PositionalArg ann_ p_
                  {-# LINE 3751 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 178, column 7)
              _lhsOliftedColumnName =
                  {-# LINE 178 "./TypeChecking/SelectLists.ag" #-}
                  ""
                  {-# LINE 3756 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  PositionalArg ann_ p_
                  {-# LINE 3761 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  PositionalArg ann_ p_
                  {-# LINE 3766 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 3771 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOliftedColumnName,_lhsOoriginalTree)))
sem_Expression_ScalarSubQuery :: Annotation ->
                                 T_SelectExpression  ->
                                 T_Expression 
sem_Expression_ScalarSubQuery ann_ sel_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Expression
              _prototype :: (Maybe FunctionPrototype)
              _lhsOliftedColumnName :: String
              _lhsOoriginalTree :: Expression
              _selOcat :: Catalog
              _selOlib :: LocalBindings
              _selIannotatedTree :: SelectExpression
              _selIlibUpdates :: ([LocalBindingsUpdate])
              _selIoriginalTree :: SelectExpression
              -- "./TypeChecking/Expressions.ag"(line 14, column 9)
              _lhsOannotatedTree =
                  {-# LINE 14 "./TypeChecking/Expressions.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ fmap ((:[]) . FunctionPrototypeA) _prototype
                  {-# LINE 3795 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 29, column 9)
              _prototype =
                  {-# LINE 29 "./TypeChecking/Expressions.ag" #-}
                  Nothing
                  {-# LINE 3800 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 271, column 9)
              _tpe =
                  {-# LINE 271 "./TypeChecking/Expressions.ag" #-}
                  do
                  let selType = getTypeAnnotation _selIannotatedTree
                  dependsOnRTpe [selType] $ do
                  f <- map snd <$> unwrapSetOfComposite selType
                  case length f of
                    0 -> Left [InternalError "no columns in scalar subquery?"]
                    1 -> Right $ head f
                    _ -> Right $ AnonymousRecordType f
                  {-# LINE 3812 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 281, column 9)
              _backTree =
                  {-# LINE 281 "./TypeChecking/Expressions.ag" #-}
                  ScalarSubQuery ann_ _selIannotatedTree
                  {-# LINE 3817 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 178, column 7)
              _lhsOliftedColumnName =
                  {-# LINE 178 "./TypeChecking/SelectLists.ag" #-}
                  ""
                  {-# LINE 3822 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  ScalarSubQuery ann_ _selIannotatedTree
                  {-# LINE 3827 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  ScalarSubQuery ann_ _selIoriginalTree
                  {-# LINE 3832 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 3837 "AstInternal.hs" #-}
              -- copy rule (down)
              _selOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 3842 "AstInternal.hs" #-}
              -- copy rule (down)
              _selOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 3847 "AstInternal.hs" #-}
              ( _selIannotatedTree,_selIlibUpdates,_selIoriginalTree) =
                  (sel_ _selOcat _selOlib )
          in  ( _lhsOannotatedTree,_lhsOliftedColumnName,_lhsOoriginalTree)))
sem_Expression_StringLit :: Annotation ->
                            String ->
                            String ->
                            T_Expression 
sem_Expression_StringLit ann_ quote_ value_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Expression
              _prototype :: (Maybe FunctionPrototype)
              _lhsOliftedColumnName :: String
              _lhsOoriginalTree :: Expression
              -- "./TypeChecking/Expressions.ag"(line 14, column 9)
              _lhsOannotatedTree =
                  {-# LINE 14 "./TypeChecking/Expressions.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ fmap ((:[]) . FunctionPrototypeA) _prototype
                  {-# LINE 3869 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 29, column 9)
              _prototype =
                  {-# LINE 29 "./TypeChecking/Expressions.ag" #-}
                  Nothing
                  {-# LINE 3874 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 39, column 18)
              _tpe =
                  {-# LINE 39 "./TypeChecking/Expressions.ag" #-}
                  Right UnknownType
                  {-# LINE 3879 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 49, column 9)
              _backTree =
                  {-# LINE 49 "./TypeChecking/Expressions.ag" #-}
                  StringLit ann_ quote_ value_
                  {-# LINE 3884 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 178, column 7)
              _lhsOliftedColumnName =
                  {-# LINE 178 "./TypeChecking/SelectLists.ag" #-}
                  ""
                  {-# LINE 3889 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  StringLit ann_ quote_ value_
                  {-# LINE 3894 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  StringLit ann_ quote_ value_
                  {-# LINE 3899 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 3904 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOliftedColumnName,_lhsOoriginalTree)))
sem_Expression_WindowFn :: Annotation ->
                           T_Expression  ->
                           T_ExpressionList  ->
                           T_ExpressionList  ->
                           T_Direction  ->
                           T_FrameClause  ->
                           T_Expression 
sem_Expression_WindowFn ann_ fn_ partitionBy_ orderBy_ dir_ frm_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Expression
              _prototype :: (Maybe FunctionPrototype)
              _lhsOoriginalTree :: Expression
              _lhsOliftedColumnName :: String
              _fnOcat :: Catalog
              _fnOlib :: LocalBindings
              _partitionByOcat :: Catalog
              _partitionByOlib :: LocalBindings
              _orderByOcat :: Catalog
              _orderByOlib :: LocalBindings
              _dirOcat :: Catalog
              _dirOlib :: LocalBindings
              _frmOcat :: Catalog
              _frmOlib :: LocalBindings
              _fnIannotatedTree :: Expression
              _fnIliftedColumnName :: String
              _fnIoriginalTree :: Expression
              _partitionByIannotatedTree :: ExpressionList
              _partitionByIoriginalTree :: ExpressionList
              _partitionByItypeList :: ([Type])
              _orderByIannotatedTree :: ExpressionList
              _orderByIoriginalTree :: ExpressionList
              _orderByItypeList :: ([Type])
              _dirIannotatedTree :: Direction
              _dirIoriginalTree :: Direction
              _frmIannotatedTree :: FrameClause
              _frmIoriginalTree :: FrameClause
              -- "./TypeChecking/Expressions.ag"(line 14, column 9)
              _lhsOannotatedTree =
                  {-# LINE 14 "./TypeChecking/Expressions.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ fmap ((:[]) . FunctionPrototypeA) _prototype
                  {-# LINE 3950 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 29, column 9)
              _prototype =
                  {-# LINE 29 "./TypeChecking/Expressions.ag" #-}
                  Nothing
                  {-# LINE 3955 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 87, column 9)
              _tpe =
                  {-# LINE 87 "./TypeChecking/Expressions.ag" #-}
                  Right (getTypeAnnotation _fnIannotatedTree)
                  {-# LINE 3960 "AstInternal.hs" #-}
              -- "./TypeChecking/Expressions.ag"(line 88, column 9)
              _backTree =
                  {-# LINE 88 "./TypeChecking/Expressions.ag" #-}
                  WindowFn ann_
                           _fnIannotatedTree
                           _partitionByIannotatedTree
                           _orderByIannotatedTree
                           _dirIannotatedTree
                           _frmIannotatedTree
                  {-# LINE 3970 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  WindowFn ann_ _fnIannotatedTree _partitionByIannotatedTree _orderByIannotatedTree _dirIannotatedTree _frmIannotatedTree
                  {-# LINE 3975 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  WindowFn ann_ _fnIoriginalTree _partitionByIoriginalTree _orderByIoriginalTree _dirIoriginalTree _frmIoriginalTree
                  {-# LINE 3980 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 3985 "AstInternal.hs" #-}
              -- copy rule (up)
              _lhsOliftedColumnName =
                  {-# LINE 162 "./TypeChecking/SelectLists.ag" #-}
                  _fnIliftedColumnName
                  {-# LINE 3990 "AstInternal.hs" #-}
              -- copy rule (down)
              _fnOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 3995 "AstInternal.hs" #-}
              -- copy rule (down)
              _fnOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4000 "AstInternal.hs" #-}
              -- copy rule (down)
              _partitionByOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4005 "AstInternal.hs" #-}
              -- copy rule (down)
              _partitionByOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4010 "AstInternal.hs" #-}
              -- copy rule (down)
              _orderByOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4015 "AstInternal.hs" #-}
              -- copy rule (down)
              _orderByOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4020 "AstInternal.hs" #-}
              -- copy rule (down)
              _dirOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4025 "AstInternal.hs" #-}
              -- copy rule (down)
              _dirOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4030 "AstInternal.hs" #-}
              -- copy rule (down)
              _frmOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4035 "AstInternal.hs" #-}
              -- copy rule (down)
              _frmOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4040 "AstInternal.hs" #-}
              ( _fnIannotatedTree,_fnIliftedColumnName,_fnIoriginalTree) =
                  (fn_ _fnOcat _fnOlib )
              ( _partitionByIannotatedTree,_partitionByIoriginalTree,_partitionByItypeList) =
                  (partitionBy_ _partitionByOcat _partitionByOlib )
              ( _orderByIannotatedTree,_orderByIoriginalTree,_orderByItypeList) =
                  (orderBy_ _orderByOcat _orderByOlib )
              ( _dirIannotatedTree,_dirIoriginalTree) =
                  (dir_ _dirOcat _dirOlib )
              ( _frmIannotatedTree,_frmIoriginalTree) =
                  (frm_ _frmOcat _frmOlib )
          in  ( _lhsOannotatedTree,_lhsOliftedColumnName,_lhsOoriginalTree)))
-- ExpressionDirectionPair -------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Tuple:
         child x1             : Expression 
         child x2             : Direction 
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type ExpressionDirectionPair  = ( (Expression),(Direction))
-- cata
sem_ExpressionDirectionPair :: ExpressionDirectionPair  ->
                               T_ExpressionDirectionPair 
sem_ExpressionDirectionPair ( x1,x2)  =
    (sem_ExpressionDirectionPair_Tuple (sem_Expression x1 ) (sem_Direction x2 ) )
-- semantic domain
type T_ExpressionDirectionPair  = Catalog ->
                                  LocalBindings ->
                                  ( ExpressionDirectionPair,ExpressionDirectionPair)
data Inh_ExpressionDirectionPair  = Inh_ExpressionDirectionPair {cat_Inh_ExpressionDirectionPair :: Catalog,lib_Inh_ExpressionDirectionPair :: LocalBindings}
data Syn_ExpressionDirectionPair  = Syn_ExpressionDirectionPair {annotatedTree_Syn_ExpressionDirectionPair :: ExpressionDirectionPair,originalTree_Syn_ExpressionDirectionPair :: ExpressionDirectionPair}
wrap_ExpressionDirectionPair :: T_ExpressionDirectionPair  ->
                                Inh_ExpressionDirectionPair  ->
                                Syn_ExpressionDirectionPair 
wrap_ExpressionDirectionPair sem (Inh_ExpressionDirectionPair _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_ExpressionDirectionPair _lhsOannotatedTree _lhsOoriginalTree ))
sem_ExpressionDirectionPair_Tuple :: T_Expression  ->
                                     T_Direction  ->
                                     T_ExpressionDirectionPair 
sem_ExpressionDirectionPair_Tuple x1_ x2_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: ExpressionDirectionPair
              _lhsOoriginalTree :: ExpressionDirectionPair
              _x1Ocat :: Catalog
              _x1Olib :: LocalBindings
              _x2Ocat :: Catalog
              _x2Olib :: LocalBindings
              _x1IannotatedTree :: Expression
              _x1IliftedColumnName :: String
              _x1IoriginalTree :: Expression
              _x2IannotatedTree :: Direction
              _x2IoriginalTree :: Direction
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (_x1IannotatedTree,_x2IannotatedTree)
                  {-# LINE 4109 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (_x1IoriginalTree,_x2IoriginalTree)
                  {-# LINE 4114 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 4119 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 4124 "AstInternal.hs" #-}
              -- copy rule (down)
              _x1Ocat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4129 "AstInternal.hs" #-}
              -- copy rule (down)
              _x1Olib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4134 "AstInternal.hs" #-}
              -- copy rule (down)
              _x2Ocat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4139 "AstInternal.hs" #-}
              -- copy rule (down)
              _x2Olib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4144 "AstInternal.hs" #-}
              ( _x1IannotatedTree,_x1IliftedColumnName,_x1IoriginalTree) =
                  (x1_ _x1Ocat _x1Olib )
              ( _x2IannotatedTree,_x2IoriginalTree) =
                  (x2_ _x2Ocat _x2Olib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- ExpressionDirectionPairList ---------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Cons:
         child hd             : ExpressionDirectionPair 
         child tl             : ExpressionDirectionPairList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type ExpressionDirectionPairList  = [(ExpressionDirectionPair)]
-- cata
sem_ExpressionDirectionPairList :: ExpressionDirectionPairList  ->
                                   T_ExpressionDirectionPairList 
sem_ExpressionDirectionPairList list  =
    (Prelude.foldr sem_ExpressionDirectionPairList_Cons sem_ExpressionDirectionPairList_Nil (Prelude.map sem_ExpressionDirectionPair list) )
-- semantic domain
type T_ExpressionDirectionPairList  = Catalog ->
                                      LocalBindings ->
                                      ( ExpressionDirectionPairList,ExpressionDirectionPairList)
data Inh_ExpressionDirectionPairList  = Inh_ExpressionDirectionPairList {cat_Inh_ExpressionDirectionPairList :: Catalog,lib_Inh_ExpressionDirectionPairList :: LocalBindings}
data Syn_ExpressionDirectionPairList  = Syn_ExpressionDirectionPairList {annotatedTree_Syn_ExpressionDirectionPairList :: ExpressionDirectionPairList,originalTree_Syn_ExpressionDirectionPairList :: ExpressionDirectionPairList}
wrap_ExpressionDirectionPairList :: T_ExpressionDirectionPairList  ->
                                    Inh_ExpressionDirectionPairList  ->
                                    Syn_ExpressionDirectionPairList 
wrap_ExpressionDirectionPairList sem (Inh_ExpressionDirectionPairList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_ExpressionDirectionPairList _lhsOannotatedTree _lhsOoriginalTree ))
sem_ExpressionDirectionPairList_Cons :: T_ExpressionDirectionPair  ->
                                        T_ExpressionDirectionPairList  ->
                                        T_ExpressionDirectionPairList 
sem_ExpressionDirectionPairList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: ExpressionDirectionPairList
              _lhsOoriginalTree :: ExpressionDirectionPairList
              _hdOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _hdIannotatedTree :: ExpressionDirectionPair
              _hdIoriginalTree :: ExpressionDirectionPair
              _tlIannotatedTree :: ExpressionDirectionPairList
              _tlIoriginalTree :: ExpressionDirectionPairList
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 4210 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 4215 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 4220 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 4225 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4230 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4235 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4240 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4245 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdIoriginalTree) =
                  (hd_ _hdOcat _hdOlib )
              ( _tlIannotatedTree,_tlIoriginalTree) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_ExpressionDirectionPairList_Nil :: T_ExpressionDirectionPairList 
sem_ExpressionDirectionPairList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: ExpressionDirectionPairList
              _lhsOoriginalTree :: ExpressionDirectionPairList
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 4261 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 4266 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 4271 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 4276 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- ExpressionList ----------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
         typeList             : [Type]
   alternatives:
      alternative Cons:
         child hd             : Expression 
         child tl             : ExpressionList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type ExpressionList  = [(Expression)]
-- cata
sem_ExpressionList :: ExpressionList  ->
                      T_ExpressionList 
sem_ExpressionList list  =
    (Prelude.foldr sem_ExpressionList_Cons sem_ExpressionList_Nil (Prelude.map sem_Expression list) )
-- semantic domain
type T_ExpressionList  = Catalog ->
                         LocalBindings ->
                         ( ExpressionList,ExpressionList,([Type]))
data Inh_ExpressionList  = Inh_ExpressionList {cat_Inh_ExpressionList :: Catalog,lib_Inh_ExpressionList :: LocalBindings}
data Syn_ExpressionList  = Syn_ExpressionList {annotatedTree_Syn_ExpressionList :: ExpressionList,originalTree_Syn_ExpressionList :: ExpressionList,typeList_Syn_ExpressionList :: [Type]}
wrap_ExpressionList :: T_ExpressionList  ->
                       Inh_ExpressionList  ->
                       Syn_ExpressionList 
wrap_ExpressionList sem (Inh_ExpressionList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOtypeList) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_ExpressionList _lhsOannotatedTree _lhsOoriginalTree _lhsOtypeList ))
sem_ExpressionList_Cons :: T_Expression  ->
                           T_ExpressionList  ->
                           T_ExpressionList 
sem_ExpressionList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOtypeList :: ([Type])
              _lhsOannotatedTree :: ExpressionList
              _lhsOoriginalTree :: ExpressionList
              _hdOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _hdIannotatedTree :: Expression
              _hdIliftedColumnName :: String
              _hdIoriginalTree :: Expression
              _tlIannotatedTree :: ExpressionList
              _tlIoriginalTree :: ExpressionList
              _tlItypeList :: ([Type])
              -- "./TypeChecking/Misc.ag"(line 52, column 12)
              _lhsOtypeList =
                  {-# LINE 52 "./TypeChecking/Misc.ag" #-}
                  getTypeAnnotation _hdIannotatedTree : _tlItypeList
                  {-# LINE 4342 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 4347 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 4352 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 4357 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 4362 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4367 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4372 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4377 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4382 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdIliftedColumnName,_hdIoriginalTree) =
                  (hd_ _hdOcat _hdOlib )
              ( _tlIannotatedTree,_tlIoriginalTree,_tlItypeList) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOtypeList)))
sem_ExpressionList_Nil :: T_ExpressionList 
sem_ExpressionList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOtypeList :: ([Type])
              _lhsOannotatedTree :: ExpressionList
              _lhsOoriginalTree :: ExpressionList
              -- "./TypeChecking/Misc.ag"(line 53, column 11)
              _lhsOtypeList =
                  {-# LINE 53 "./TypeChecking/Misc.ag" #-}
                  []
                  {-# LINE 4399 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 4404 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 4409 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 4414 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 4419 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOtypeList)))
-- ExpressionListList ------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
         typeListList         : [[Type]]
   alternatives:
      alternative Cons:
         child hd             : ExpressionList 
         child tl             : ExpressionListList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type ExpressionListList  = [(ExpressionList)]
-- cata
sem_ExpressionListList :: ExpressionListList  ->
                          T_ExpressionListList 
sem_ExpressionListList list  =
    (Prelude.foldr sem_ExpressionListList_Cons sem_ExpressionListList_Nil (Prelude.map sem_ExpressionList list) )
-- semantic domain
type T_ExpressionListList  = Catalog ->
                             LocalBindings ->
                             ( ExpressionListList,ExpressionListList,([[Type]]))
data Inh_ExpressionListList  = Inh_ExpressionListList {cat_Inh_ExpressionListList :: Catalog,lib_Inh_ExpressionListList :: LocalBindings}
data Syn_ExpressionListList  = Syn_ExpressionListList {annotatedTree_Syn_ExpressionListList :: ExpressionListList,originalTree_Syn_ExpressionListList :: ExpressionListList,typeListList_Syn_ExpressionListList :: [[Type]]}
wrap_ExpressionListList :: T_ExpressionListList  ->
                           Inh_ExpressionListList  ->
                           Syn_ExpressionListList 
wrap_ExpressionListList sem (Inh_ExpressionListList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOtypeListList) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_ExpressionListList _lhsOannotatedTree _lhsOoriginalTree _lhsOtypeListList ))
sem_ExpressionListList_Cons :: T_ExpressionList  ->
                               T_ExpressionListList  ->
                               T_ExpressionListList 
sem_ExpressionListList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOtypeListList :: ([[Type]])
              _lhsOannotatedTree :: ExpressionListList
              _lhsOoriginalTree :: ExpressionListList
              _hdOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _hdIannotatedTree :: ExpressionList
              _hdIoriginalTree :: ExpressionList
              _hdItypeList :: ([Type])
              _tlIannotatedTree :: ExpressionListList
              _tlIoriginalTree :: ExpressionListList
              _tlItypeListList :: ([[Type]])
              -- "./TypeChecking/Misc.ag"(line 59, column 12)
              _lhsOtypeListList =
                  {-# LINE 59 "./TypeChecking/Misc.ag" #-}
                  _hdItypeList : _tlItypeListList
                  {-# LINE 4485 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 4490 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 4495 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 4500 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 4505 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4510 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4515 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4520 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4525 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdIoriginalTree,_hdItypeList) =
                  (hd_ _hdOcat _hdOlib )
              ( _tlIannotatedTree,_tlIoriginalTree,_tlItypeListList) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOtypeListList)))
sem_ExpressionListList_Nil :: T_ExpressionListList 
sem_ExpressionListList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOtypeListList :: ([[Type]])
              _lhsOannotatedTree :: ExpressionListList
              _lhsOoriginalTree :: ExpressionListList
              -- "./TypeChecking/Misc.ag"(line 60, column 11)
              _lhsOtypeListList =
                  {-# LINE 60 "./TypeChecking/Misc.ag" #-}
                  []
                  {-# LINE 4542 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 4547 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 4552 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 4557 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 4562 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOtypeListList)))
-- ExpressionListStatementListPair -----------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Tuple:
         child x1             : ExpressionList 
         child x2             : StatementList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type ExpressionListStatementListPair  = ( (ExpressionList),(StatementList))
-- cata
sem_ExpressionListStatementListPair :: ExpressionListStatementListPair  ->
                                       T_ExpressionListStatementListPair 
sem_ExpressionListStatementListPair ( x1,x2)  =
    (sem_ExpressionListStatementListPair_Tuple (sem_ExpressionList x1 ) (sem_StatementList x2 ) )
-- semantic domain
type T_ExpressionListStatementListPair  = Catalog ->
                                          LocalBindings ->
                                          ( ExpressionListStatementListPair,ExpressionListStatementListPair)
data Inh_ExpressionListStatementListPair  = Inh_ExpressionListStatementListPair {cat_Inh_ExpressionListStatementListPair :: Catalog,lib_Inh_ExpressionListStatementListPair :: LocalBindings}
data Syn_ExpressionListStatementListPair  = Syn_ExpressionListStatementListPair {annotatedTree_Syn_ExpressionListStatementListPair :: ExpressionListStatementListPair,originalTree_Syn_ExpressionListStatementListPair :: ExpressionListStatementListPair}
wrap_ExpressionListStatementListPair :: T_ExpressionListStatementListPair  ->
                                        Inh_ExpressionListStatementListPair  ->
                                        Syn_ExpressionListStatementListPair 
wrap_ExpressionListStatementListPair sem (Inh_ExpressionListStatementListPair _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_ExpressionListStatementListPair _lhsOannotatedTree _lhsOoriginalTree ))
sem_ExpressionListStatementListPair_Tuple :: T_ExpressionList  ->
                                             T_StatementList  ->
                                             T_ExpressionListStatementListPair 
sem_ExpressionListStatementListPair_Tuple x1_ x2_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _x2OcatUpdates :: ([CatalogUpdate])
              _x2OlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: ExpressionListStatementListPair
              _lhsOoriginalTree :: ExpressionListStatementListPair
              _x1Ocat :: Catalog
              _x1Olib :: LocalBindings
              _x2Ocat :: Catalog
              _x2Olib :: LocalBindings
              _x1IannotatedTree :: ExpressionList
              _x1IoriginalTree :: ExpressionList
              _x1ItypeList :: ([Type])
              _x2IannotatedTree :: StatementList
              _x2IoriginalTree :: StatementList
              _x2IproducedCat :: Catalog
              _x2IproducedLib :: LocalBindings
              -- "./TypeChecking/Statements.ag"(line 94, column 9)
              _x2OcatUpdates =
                  {-# LINE 94 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 4625 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 95, column 9)
              _x2OlibUpdates =
                  {-# LINE 95 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 4630 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (_x1IannotatedTree,_x2IannotatedTree)
                  {-# LINE 4635 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (_x1IoriginalTree,_x2IoriginalTree)
                  {-# LINE 4640 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 4645 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 4650 "AstInternal.hs" #-}
              -- copy rule (down)
              _x1Ocat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4655 "AstInternal.hs" #-}
              -- copy rule (down)
              _x1Olib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4660 "AstInternal.hs" #-}
              -- copy rule (down)
              _x2Ocat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4665 "AstInternal.hs" #-}
              -- copy rule (down)
              _x2Olib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4670 "AstInternal.hs" #-}
              ( _x1IannotatedTree,_x1IoriginalTree,_x1ItypeList) =
                  (x1_ _x1Ocat _x1Olib )
              ( _x2IannotatedTree,_x2IoriginalTree,_x2IproducedCat,_x2IproducedLib) =
                  (x2_ _x2Ocat _x2OcatUpdates _x2Olib _x2OlibUpdates )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- ExpressionListStatementListPairList -------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Cons:
         child hd             : ExpressionListStatementListPair 
         child tl             : ExpressionListStatementListPairList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type ExpressionListStatementListPairList  = [(ExpressionListStatementListPair)]
-- cata
sem_ExpressionListStatementListPairList :: ExpressionListStatementListPairList  ->
                                           T_ExpressionListStatementListPairList 
sem_ExpressionListStatementListPairList list  =
    (Prelude.foldr sem_ExpressionListStatementListPairList_Cons sem_ExpressionListStatementListPairList_Nil (Prelude.map sem_ExpressionListStatementListPair list) )
-- semantic domain
type T_ExpressionListStatementListPairList  = Catalog ->
                                              LocalBindings ->
                                              ( ExpressionListStatementListPairList,ExpressionListStatementListPairList)
data Inh_ExpressionListStatementListPairList  = Inh_ExpressionListStatementListPairList {cat_Inh_ExpressionListStatementListPairList :: Catalog,lib_Inh_ExpressionListStatementListPairList :: LocalBindings}
data Syn_ExpressionListStatementListPairList  = Syn_ExpressionListStatementListPairList {annotatedTree_Syn_ExpressionListStatementListPairList :: ExpressionListStatementListPairList,originalTree_Syn_ExpressionListStatementListPairList :: ExpressionListStatementListPairList}
wrap_ExpressionListStatementListPairList :: T_ExpressionListStatementListPairList  ->
                                            Inh_ExpressionListStatementListPairList  ->
                                            Syn_ExpressionListStatementListPairList 
wrap_ExpressionListStatementListPairList sem (Inh_ExpressionListStatementListPairList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_ExpressionListStatementListPairList _lhsOannotatedTree _lhsOoriginalTree ))
sem_ExpressionListStatementListPairList_Cons :: T_ExpressionListStatementListPair  ->
                                                T_ExpressionListStatementListPairList  ->
                                                T_ExpressionListStatementListPairList 
sem_ExpressionListStatementListPairList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: ExpressionListStatementListPairList
              _lhsOoriginalTree :: ExpressionListStatementListPairList
              _hdOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _hdIannotatedTree :: ExpressionListStatementListPair
              _hdIoriginalTree :: ExpressionListStatementListPair
              _tlIannotatedTree :: ExpressionListStatementListPairList
              _tlIoriginalTree :: ExpressionListStatementListPairList
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 4736 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 4741 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 4746 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 4751 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4756 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4761 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4766 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4771 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdIoriginalTree) =
                  (hd_ _hdOcat _hdOlib )
              ( _tlIannotatedTree,_tlIoriginalTree) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_ExpressionListStatementListPairList_Nil :: T_ExpressionListStatementListPairList 
sem_ExpressionListStatementListPairList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: ExpressionListStatementListPairList
              _lhsOoriginalTree :: ExpressionListStatementListPairList
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 4787 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 4792 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 4797 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 4802 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- ExpressionRoot ----------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative ExpressionRoot:
         child expr           : Expression 
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data ExpressionRoot  = ExpressionRoot (Expression) 
                     deriving ( Show)
-- cata
sem_ExpressionRoot :: ExpressionRoot  ->
                      T_ExpressionRoot 
sem_ExpressionRoot (ExpressionRoot _expr )  =
    (sem_ExpressionRoot_ExpressionRoot (sem_Expression _expr ) )
-- semantic domain
type T_ExpressionRoot  = Catalog ->
                         LocalBindings ->
                         ( ExpressionRoot,ExpressionRoot)
data Inh_ExpressionRoot  = Inh_ExpressionRoot {cat_Inh_ExpressionRoot :: Catalog,lib_Inh_ExpressionRoot :: LocalBindings}
data Syn_ExpressionRoot  = Syn_ExpressionRoot {annotatedTree_Syn_ExpressionRoot :: ExpressionRoot,originalTree_Syn_ExpressionRoot :: ExpressionRoot}
wrap_ExpressionRoot :: T_ExpressionRoot  ->
                       Inh_ExpressionRoot  ->
                       Syn_ExpressionRoot 
wrap_ExpressionRoot sem (Inh_ExpressionRoot _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_ExpressionRoot _lhsOannotatedTree _lhsOoriginalTree ))
sem_ExpressionRoot_ExpressionRoot :: T_Expression  ->
                                     T_ExpressionRoot 
sem_ExpressionRoot_ExpressionRoot expr_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: ExpressionRoot
              _lhsOoriginalTree :: ExpressionRoot
              _exprOcat :: Catalog
              _exprOlib :: LocalBindings
              _exprIannotatedTree :: Expression
              _exprIliftedColumnName :: String
              _exprIoriginalTree :: Expression
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  ExpressionRoot _exprIannotatedTree
                  {-# LINE 4856 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  ExpressionRoot _exprIoriginalTree
                  {-# LINE 4861 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 4866 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 4871 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4876 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4881 "AstInternal.hs" #-}
              ( _exprIannotatedTree,_exprIliftedColumnName,_exprIoriginalTree) =
                  (expr_ _exprOcat _exprOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- ExpressionStatementListPair ---------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Tuple:
         child x1             : Expression 
         child x2             : StatementList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type ExpressionStatementListPair  = ( (Expression),(StatementList))
-- cata
sem_ExpressionStatementListPair :: ExpressionStatementListPair  ->
                                   T_ExpressionStatementListPair 
sem_ExpressionStatementListPair ( x1,x2)  =
    (sem_ExpressionStatementListPair_Tuple (sem_Expression x1 ) (sem_StatementList x2 ) )
-- semantic domain
type T_ExpressionStatementListPair  = Catalog ->
                                      LocalBindings ->
                                      ( ExpressionStatementListPair,ExpressionStatementListPair)
data Inh_ExpressionStatementListPair  = Inh_ExpressionStatementListPair {cat_Inh_ExpressionStatementListPair :: Catalog,lib_Inh_ExpressionStatementListPair :: LocalBindings}
data Syn_ExpressionStatementListPair  = Syn_ExpressionStatementListPair {annotatedTree_Syn_ExpressionStatementListPair :: ExpressionStatementListPair,originalTree_Syn_ExpressionStatementListPair :: ExpressionStatementListPair}
wrap_ExpressionStatementListPair :: T_ExpressionStatementListPair  ->
                                    Inh_ExpressionStatementListPair  ->
                                    Syn_ExpressionStatementListPair 
wrap_ExpressionStatementListPair sem (Inh_ExpressionStatementListPair _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_ExpressionStatementListPair _lhsOannotatedTree _lhsOoriginalTree ))
sem_ExpressionStatementListPair_Tuple :: T_Expression  ->
                                         T_StatementList  ->
                                         T_ExpressionStatementListPair 
sem_ExpressionStatementListPair_Tuple x1_ x2_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _x2OcatUpdates :: ([CatalogUpdate])
              _x2OlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: ExpressionStatementListPair
              _lhsOoriginalTree :: ExpressionStatementListPair
              _x1Ocat :: Catalog
              _x1Olib :: LocalBindings
              _x2Ocat :: Catalog
              _x2Olib :: LocalBindings
              _x1IannotatedTree :: Expression
              _x1IliftedColumnName :: String
              _x1IoriginalTree :: Expression
              _x2IannotatedTree :: StatementList
              _x2IoriginalTree :: StatementList
              _x2IproducedCat :: Catalog
              _x2IproducedLib :: LocalBindings
              -- "./TypeChecking/Statements.ag"(line 98, column 9)
              _x2OcatUpdates =
                  {-# LINE 98 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 4946 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 99, column 9)
              _x2OlibUpdates =
                  {-# LINE 99 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 4951 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (_x1IannotatedTree,_x2IannotatedTree)
                  {-# LINE 4956 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (_x1IoriginalTree,_x2IoriginalTree)
                  {-# LINE 4961 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 4966 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 4971 "AstInternal.hs" #-}
              -- copy rule (down)
              _x1Ocat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4976 "AstInternal.hs" #-}
              -- copy rule (down)
              _x1Olib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4981 "AstInternal.hs" #-}
              -- copy rule (down)
              _x2Ocat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 4986 "AstInternal.hs" #-}
              -- copy rule (down)
              _x2Olib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 4991 "AstInternal.hs" #-}
              ( _x1IannotatedTree,_x1IliftedColumnName,_x1IoriginalTree) =
                  (x1_ _x1Ocat _x1Olib )
              ( _x2IannotatedTree,_x2IoriginalTree,_x2IproducedCat,_x2IproducedLib) =
                  (x2_ _x2Ocat _x2OcatUpdates _x2Olib _x2OlibUpdates )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- ExpressionStatementListPairList -----------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Cons:
         child hd             : ExpressionStatementListPair 
         child tl             : ExpressionStatementListPairList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type ExpressionStatementListPairList  = [(ExpressionStatementListPair)]
-- cata
sem_ExpressionStatementListPairList :: ExpressionStatementListPairList  ->
                                       T_ExpressionStatementListPairList 
sem_ExpressionStatementListPairList list  =
    (Prelude.foldr sem_ExpressionStatementListPairList_Cons sem_ExpressionStatementListPairList_Nil (Prelude.map sem_ExpressionStatementListPair list) )
-- semantic domain
type T_ExpressionStatementListPairList  = Catalog ->
                                          LocalBindings ->
                                          ( ExpressionStatementListPairList,ExpressionStatementListPairList)
data Inh_ExpressionStatementListPairList  = Inh_ExpressionStatementListPairList {cat_Inh_ExpressionStatementListPairList :: Catalog,lib_Inh_ExpressionStatementListPairList :: LocalBindings}
data Syn_ExpressionStatementListPairList  = Syn_ExpressionStatementListPairList {annotatedTree_Syn_ExpressionStatementListPairList :: ExpressionStatementListPairList,originalTree_Syn_ExpressionStatementListPairList :: ExpressionStatementListPairList}
wrap_ExpressionStatementListPairList :: T_ExpressionStatementListPairList  ->
                                        Inh_ExpressionStatementListPairList  ->
                                        Syn_ExpressionStatementListPairList 
wrap_ExpressionStatementListPairList sem (Inh_ExpressionStatementListPairList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_ExpressionStatementListPairList _lhsOannotatedTree _lhsOoriginalTree ))
sem_ExpressionStatementListPairList_Cons :: T_ExpressionStatementListPair  ->
                                            T_ExpressionStatementListPairList  ->
                                            T_ExpressionStatementListPairList 
sem_ExpressionStatementListPairList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: ExpressionStatementListPairList
              _lhsOoriginalTree :: ExpressionStatementListPairList
              _hdOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _hdIannotatedTree :: ExpressionStatementListPair
              _hdIoriginalTree :: ExpressionStatementListPair
              _tlIannotatedTree :: ExpressionStatementListPairList
              _tlIoriginalTree :: ExpressionStatementListPairList
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 5057 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 5062 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 5067 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 5072 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 5077 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 5082 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 5087 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 5092 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdIoriginalTree) =
                  (hd_ _hdOcat _hdOlib )
              ( _tlIannotatedTree,_tlIoriginalTree) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_ExpressionStatementListPairList_Nil :: T_ExpressionStatementListPairList 
sem_ExpressionStatementListPairList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: ExpressionStatementListPairList
              _lhsOoriginalTree :: ExpressionStatementListPairList
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 5108 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 5113 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 5118 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 5123 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- FnBody ------------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative PlpgsqlFnBody:
         child ann            : {Annotation}
         child vars           : VarDefList 
         child sts            : StatementList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative SqlFnBody:
         child ann            : {Annotation}
         child sts            : StatementList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data FnBody  = PlpgsqlFnBody (Annotation) (VarDefList) (StatementList) 
             | SqlFnBody (Annotation) (StatementList) 
             deriving ( Data,Eq,Show,Typeable)
-- cata
sem_FnBody :: FnBody  ->
              T_FnBody 
sem_FnBody (PlpgsqlFnBody _ann _vars _sts )  =
    (sem_FnBody_PlpgsqlFnBody _ann (sem_VarDefList _vars ) (sem_StatementList _sts ) )
sem_FnBody (SqlFnBody _ann _sts )  =
    (sem_FnBody_SqlFnBody _ann (sem_StatementList _sts ) )
-- semantic domain
type T_FnBody  = Catalog ->
                 LocalBindings ->
                 ( FnBody,FnBody)
data Inh_FnBody  = Inh_FnBody {cat_Inh_FnBody :: Catalog,lib_Inh_FnBody :: LocalBindings}
data Syn_FnBody  = Syn_FnBody {annotatedTree_Syn_FnBody :: FnBody,originalTree_Syn_FnBody :: FnBody}
wrap_FnBody :: T_FnBody  ->
               Inh_FnBody  ->
               Syn_FnBody 
wrap_FnBody sem (Inh_FnBody _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_FnBody _lhsOannotatedTree _lhsOoriginalTree ))
sem_FnBody_PlpgsqlFnBody :: Annotation ->
                            T_VarDefList  ->
                            T_StatementList  ->
                            T_FnBody 
sem_FnBody_PlpgsqlFnBody ann_ vars_ sts_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _stsOcatUpdates :: ([CatalogUpdate])
              _stsOlibUpdates :: ([LocalBindingsUpdate])
              _stsOlib :: LocalBindings
              _lhsOannotatedTree :: FnBody
              _lhsOoriginalTree :: FnBody
              _varsOcat :: Catalog
              _varsOlib :: LocalBindings
              _stsOcat :: Catalog
              _varsIannotatedTree :: VarDefList
              _varsIdefs :: ([(String,Type)])
              _varsIoriginalTree :: VarDefList
              _stsIannotatedTree :: StatementList
              _stsIoriginalTree :: StatementList
              _stsIproducedCat :: Catalog
              _stsIproducedLib :: LocalBindings
              -- "./TypeChecking/Statements.ag"(line 102, column 9)
              _stsOcatUpdates =
                  {-# LINE 102 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 5198 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 103, column 9)
              _stsOlibUpdates =
                  {-# LINE 103 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 5203 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateFunction.ag"(line 120, column 9)
              _stsOlib =
                  {-# LINE 120 "./TypeChecking/CreateFunction.ag" #-}
                  fromRight _lhsIlib $
                  lbUpdate _lhsIcat _lhsIlib $
                    LBIds "declarations" "" _varsIdefs []
                  {-# LINE 5210 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  PlpgsqlFnBody ann_ _varsIannotatedTree _stsIannotatedTree
                  {-# LINE 5215 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  PlpgsqlFnBody ann_ _varsIoriginalTree _stsIoriginalTree
                  {-# LINE 5220 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 5225 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 5230 "AstInternal.hs" #-}
              -- copy rule (down)
              _varsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 5235 "AstInternal.hs" #-}
              -- copy rule (down)
              _varsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 5240 "AstInternal.hs" #-}
              -- copy rule (down)
              _stsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 5245 "AstInternal.hs" #-}
              ( _varsIannotatedTree,_varsIdefs,_varsIoriginalTree) =
                  (vars_ _varsOcat _varsOlib )
              ( _stsIannotatedTree,_stsIoriginalTree,_stsIproducedCat,_stsIproducedLib) =
                  (sts_ _stsOcat _stsOcatUpdates _stsOlib _stsOlibUpdates )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_FnBody_SqlFnBody :: Annotation ->
                        T_StatementList  ->
                        T_FnBody 
sem_FnBody_SqlFnBody ann_ sts_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _stsOcatUpdates :: ([CatalogUpdate])
              _stsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: FnBody
              _lhsOoriginalTree :: FnBody
              _stsOcat :: Catalog
              _stsOlib :: LocalBindings
              _stsIannotatedTree :: StatementList
              _stsIoriginalTree :: StatementList
              _stsIproducedCat :: Catalog
              _stsIproducedLib :: LocalBindings
              -- "./TypeChecking/Statements.ag"(line 102, column 9)
              _stsOcatUpdates =
                  {-# LINE 102 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 5271 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 103, column 9)
              _stsOlibUpdates =
                  {-# LINE 103 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 5276 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  SqlFnBody ann_ _stsIannotatedTree
                  {-# LINE 5281 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  SqlFnBody ann_ _stsIoriginalTree
                  {-# LINE 5286 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 5291 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 5296 "AstInternal.hs" #-}
              -- copy rule (down)
              _stsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 5301 "AstInternal.hs" #-}
              -- copy rule (down)
              _stsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 5306 "AstInternal.hs" #-}
              ( _stsIannotatedTree,_stsIoriginalTree,_stsIproducedCat,_stsIproducedLib) =
                  (sts_ _stsOcat _stsOcatUpdates _stsOlib _stsOlibUpdates )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- FrameClause -------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative FrameRowsUnboundedPreceding:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative FrameUnboundedFull:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative FrameUnboundedPreceding:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data FrameClause  = FrameRowsUnboundedPreceding 
                  | FrameUnboundedFull 
                  | FrameUnboundedPreceding 
                  deriving ( Data,Eq,Show,Typeable)
-- cata
sem_FrameClause :: FrameClause  ->
                   T_FrameClause 
sem_FrameClause (FrameRowsUnboundedPreceding )  =
    (sem_FrameClause_FrameRowsUnboundedPreceding )
sem_FrameClause (FrameUnboundedFull )  =
    (sem_FrameClause_FrameUnboundedFull )
sem_FrameClause (FrameUnboundedPreceding )  =
    (sem_FrameClause_FrameUnboundedPreceding )
-- semantic domain
type T_FrameClause  = Catalog ->
                      LocalBindings ->
                      ( FrameClause,FrameClause)
data Inh_FrameClause  = Inh_FrameClause {cat_Inh_FrameClause :: Catalog,lib_Inh_FrameClause :: LocalBindings}
data Syn_FrameClause  = Syn_FrameClause {annotatedTree_Syn_FrameClause :: FrameClause,originalTree_Syn_FrameClause :: FrameClause}
wrap_FrameClause :: T_FrameClause  ->
                    Inh_FrameClause  ->
                    Syn_FrameClause 
wrap_FrameClause sem (Inh_FrameClause _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_FrameClause _lhsOannotatedTree _lhsOoriginalTree ))
sem_FrameClause_FrameRowsUnboundedPreceding :: T_FrameClause 
sem_FrameClause_FrameRowsUnboundedPreceding  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: FrameClause
              _lhsOoriginalTree :: FrameClause
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  FrameRowsUnboundedPreceding
                  {-# LINE 5369 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  FrameRowsUnboundedPreceding
                  {-# LINE 5374 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 5379 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 5384 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_FrameClause_FrameUnboundedFull :: T_FrameClause 
sem_FrameClause_FrameUnboundedFull  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: FrameClause
              _lhsOoriginalTree :: FrameClause
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  FrameUnboundedFull
                  {-# LINE 5396 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  FrameUnboundedFull
                  {-# LINE 5401 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 5406 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 5411 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_FrameClause_FrameUnboundedPreceding :: T_FrameClause 
sem_FrameClause_FrameUnboundedPreceding  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: FrameClause
              _lhsOoriginalTree :: FrameClause
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  FrameUnboundedPreceding
                  {-# LINE 5423 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  FrameUnboundedPreceding
                  {-# LINE 5428 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 5433 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 5438 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- IfExists ----------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative IfExists:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Require:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data IfExists  = IfExists 
               | Require 
               deriving ( Data,Eq,Show,Typeable)
-- cata
sem_IfExists :: IfExists  ->
                T_IfExists 
sem_IfExists (IfExists )  =
    (sem_IfExists_IfExists )
sem_IfExists (Require )  =
    (sem_IfExists_Require )
-- semantic domain
type T_IfExists  = Catalog ->
                   LocalBindings ->
                   ( IfExists,IfExists)
data Inh_IfExists  = Inh_IfExists {cat_Inh_IfExists :: Catalog,lib_Inh_IfExists :: LocalBindings}
data Syn_IfExists  = Syn_IfExists {annotatedTree_Syn_IfExists :: IfExists,originalTree_Syn_IfExists :: IfExists}
wrap_IfExists :: T_IfExists  ->
                 Inh_IfExists  ->
                 Syn_IfExists 
wrap_IfExists sem (Inh_IfExists _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_IfExists _lhsOannotatedTree _lhsOoriginalTree ))
sem_IfExists_IfExists :: T_IfExists 
sem_IfExists_IfExists  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: IfExists
              _lhsOoriginalTree :: IfExists
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  IfExists
                  {-# LINE 5492 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  IfExists
                  {-# LINE 5497 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 5502 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 5507 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_IfExists_Require :: T_IfExists 
sem_IfExists_Require  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: IfExists
              _lhsOoriginalTree :: IfExists
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Require
                  {-# LINE 5519 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Require
                  {-# LINE 5524 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 5529 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 5534 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- InList ------------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         listType             : Either [TypeError] Type
         originalTree         : SELF 
   alternatives:
      alternative InList:
         child ann            : {Annotation}
         child exprs          : ExpressionList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative InSelect:
         child ann            : {Annotation}
         child sel            : SelectExpression 
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data InList  = InList (Annotation) (ExpressionList) 
             | InSelect (Annotation) (SelectExpression) 
             deriving ( Data,Eq,Show,Typeable)
-- cata
sem_InList :: InList  ->
              T_InList 
sem_InList (InList _ann _exprs )  =
    (sem_InList_InList _ann (sem_ExpressionList _exprs ) )
sem_InList (InSelect _ann _sel )  =
    (sem_InList_InSelect _ann (sem_SelectExpression _sel ) )
-- semantic domain
type T_InList  = Catalog ->
                 LocalBindings ->
                 ( InList,(Either [TypeError] Type),InList)
data Inh_InList  = Inh_InList {cat_Inh_InList :: Catalog,lib_Inh_InList :: LocalBindings}
data Syn_InList  = Syn_InList {annotatedTree_Syn_InList :: InList,listType_Syn_InList :: Either [TypeError] Type,originalTree_Syn_InList :: InList}
wrap_InList :: T_InList  ->
               Inh_InList  ->
               Syn_InList 
wrap_InList sem (Inh_InList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOlistType,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_InList _lhsOannotatedTree _lhsOlistType _lhsOoriginalTree ))
sem_InList_InList :: Annotation ->
                     T_ExpressionList  ->
                     T_InList 
sem_InList_InList ann_ exprs_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOlistType :: (Either [TypeError] Type)
              _lhsOannotatedTree :: InList
              _lhsOoriginalTree :: InList
              _exprsOcat :: Catalog
              _exprsOlib :: LocalBindings
              _exprsIannotatedTree :: ExpressionList
              _exprsIoriginalTree :: ExpressionList
              _exprsItypeList :: ([Type])
              -- "./TypeChecking/Expressions.ag"(line 305, column 9)
              _lhsOlistType =
                  {-# LINE 305 "./TypeChecking/Expressions.ag" #-}
                  resolveResultSetType _lhsIcat _exprsItypeList
                  {-# LINE 5601 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  InList ann_ _exprsIannotatedTree
                  {-# LINE 5606 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  InList ann_ _exprsIoriginalTree
                  {-# LINE 5611 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 5616 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 5621 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 5626 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 5631 "AstInternal.hs" #-}
              ( _exprsIannotatedTree,_exprsIoriginalTree,_exprsItypeList) =
                  (exprs_ _exprsOcat _exprsOlib )
          in  ( _lhsOannotatedTree,_lhsOlistType,_lhsOoriginalTree)))
sem_InList_InSelect :: Annotation ->
                       T_SelectExpression  ->
                       T_InList 
sem_InList_InSelect ann_ sel_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOlistType :: (Either [TypeError] Type)
              _lhsOannotatedTree :: InList
              _lhsOoriginalTree :: InList
              _selOcat :: Catalog
              _selOlib :: LocalBindings
              _selIannotatedTree :: SelectExpression
              _selIlibUpdates :: ([LocalBindingsUpdate])
              _selIoriginalTree :: SelectExpression
              -- "./TypeChecking/Expressions.ag"(line 307, column 9)
              _lhsOlistType =
                  {-# LINE 307 "./TypeChecking/Expressions.ag" #-}
                  do
                  attrs <- map snd <$> (unwrapSetOfComposite $
                                        getTypeAnnotation _selIannotatedTree)
                  typ <- case length attrs of
                            0 -> Left [InternalError
                                       "got subquery with no columns? in inselect"]
                            1 -> Right $ head attrs
                            _ -> Right $ AnonymousRecordType attrs
                  dependsOnRTpe attrs $ Right typ
                  {-# LINE 5661 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  InSelect ann_ _selIannotatedTree
                  {-# LINE 5666 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  InSelect ann_ _selIoriginalTree
                  {-# LINE 5671 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 5676 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 5681 "AstInternal.hs" #-}
              -- copy rule (down)
              _selOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 5686 "AstInternal.hs" #-}
              -- copy rule (down)
              _selOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 5691 "AstInternal.hs" #-}
              ( _selIannotatedTree,_selIlibUpdates,_selIoriginalTree) =
                  (sel_ _selOcat _selOlib )
          in  ( _lhsOannotatedTree,_lhsOlistType,_lhsOoriginalTree)))
-- JoinExpression ----------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative JoinOn:
         child ann            : {Annotation}
         child expression     : Expression 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative JoinUsing:
         child ann            : {Annotation}
         child stringList     : StringList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data JoinExpression  = JoinOn (Annotation) (Expression) 
                     | JoinUsing (Annotation) (StringList) 
                     deriving ( Data,Eq,Show,Typeable)
-- cata
sem_JoinExpression :: JoinExpression  ->
                      T_JoinExpression 
sem_JoinExpression (JoinOn _ann _expression )  =
    (sem_JoinExpression_JoinOn _ann (sem_Expression _expression ) )
sem_JoinExpression (JoinUsing _ann _stringList )  =
    (sem_JoinExpression_JoinUsing _ann (sem_StringList _stringList ) )
-- semantic domain
type T_JoinExpression  = Catalog ->
                         LocalBindings ->
                         ( JoinExpression,JoinExpression)
data Inh_JoinExpression  = Inh_JoinExpression {cat_Inh_JoinExpression :: Catalog,lib_Inh_JoinExpression :: LocalBindings}
data Syn_JoinExpression  = Syn_JoinExpression {annotatedTree_Syn_JoinExpression :: JoinExpression,originalTree_Syn_JoinExpression :: JoinExpression}
wrap_JoinExpression :: T_JoinExpression  ->
                       Inh_JoinExpression  ->
                       Syn_JoinExpression 
wrap_JoinExpression sem (Inh_JoinExpression _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_JoinExpression _lhsOannotatedTree _lhsOoriginalTree ))
sem_JoinExpression_JoinOn :: Annotation ->
                             T_Expression  ->
                             T_JoinExpression 
sem_JoinExpression_JoinOn ann_ expression_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: JoinExpression
              _lhsOoriginalTree :: JoinExpression
              _expressionOcat :: Catalog
              _expressionOlib :: LocalBindings
              _expressionIannotatedTree :: Expression
              _expressionIliftedColumnName :: String
              _expressionIoriginalTree :: Expression
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  JoinOn ann_ _expressionIannotatedTree
                  {-# LINE 5758 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  JoinOn ann_ _expressionIoriginalTree
                  {-# LINE 5763 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 5768 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 5773 "AstInternal.hs" #-}
              -- copy rule (down)
              _expressionOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 5778 "AstInternal.hs" #-}
              -- copy rule (down)
              _expressionOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 5783 "AstInternal.hs" #-}
              ( _expressionIannotatedTree,_expressionIliftedColumnName,_expressionIoriginalTree) =
                  (expression_ _expressionOcat _expressionOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_JoinExpression_JoinUsing :: Annotation ->
                                T_StringList  ->
                                T_JoinExpression 
sem_JoinExpression_JoinUsing ann_ stringList_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: JoinExpression
              _lhsOoriginalTree :: JoinExpression
              _stringListOcat :: Catalog
              _stringListOlib :: LocalBindings
              _stringListIannotatedTree :: StringList
              _stringListIoriginalTree :: StringList
              _stringListIstrings :: ([String])
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  JoinUsing ann_ _stringListIannotatedTree
                  {-# LINE 5804 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  JoinUsing ann_ _stringListIoriginalTree
                  {-# LINE 5809 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 5814 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 5819 "AstInternal.hs" #-}
              -- copy rule (down)
              _stringListOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 5824 "AstInternal.hs" #-}
              -- copy rule (down)
              _stringListOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 5829 "AstInternal.hs" #-}
              ( _stringListIannotatedTree,_stringListIoriginalTree,_stringListIstrings) =
                  (stringList_ _stringListOcat _stringListOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- JoinType ----------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Cross:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative FullOuter:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Inner:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative LeftOuter:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative RightOuter:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data JoinType  = Cross 
               | FullOuter 
               | Inner 
               | LeftOuter 
               | RightOuter 
               deriving ( Data,Eq,Show,Typeable)
-- cata
sem_JoinType :: JoinType  ->
                T_JoinType 
sem_JoinType (Cross )  =
    (sem_JoinType_Cross )
sem_JoinType (FullOuter )  =
    (sem_JoinType_FullOuter )
sem_JoinType (Inner )  =
    (sem_JoinType_Inner )
sem_JoinType (LeftOuter )  =
    (sem_JoinType_LeftOuter )
sem_JoinType (RightOuter )  =
    (sem_JoinType_RightOuter )
-- semantic domain
type T_JoinType  = Catalog ->
                   LocalBindings ->
                   ( JoinType,JoinType)
data Inh_JoinType  = Inh_JoinType {cat_Inh_JoinType :: Catalog,lib_Inh_JoinType :: LocalBindings}
data Syn_JoinType  = Syn_JoinType {annotatedTree_Syn_JoinType :: JoinType,originalTree_Syn_JoinType :: JoinType}
wrap_JoinType :: T_JoinType  ->
                 Inh_JoinType  ->
                 Syn_JoinType 
wrap_JoinType sem (Inh_JoinType _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_JoinType _lhsOannotatedTree _lhsOoriginalTree ))
sem_JoinType_Cross :: T_JoinType 
sem_JoinType_Cross  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: JoinType
              _lhsOoriginalTree :: JoinType
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Cross
                  {-# LINE 5906 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Cross
                  {-# LINE 5911 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 5916 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 5921 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_JoinType_FullOuter :: T_JoinType 
sem_JoinType_FullOuter  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: JoinType
              _lhsOoriginalTree :: JoinType
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  FullOuter
                  {-# LINE 5933 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  FullOuter
                  {-# LINE 5938 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 5943 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 5948 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_JoinType_Inner :: T_JoinType 
sem_JoinType_Inner  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: JoinType
              _lhsOoriginalTree :: JoinType
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Inner
                  {-# LINE 5960 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Inner
                  {-# LINE 5965 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 5970 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 5975 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_JoinType_LeftOuter :: T_JoinType 
sem_JoinType_LeftOuter  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: JoinType
              _lhsOoriginalTree :: JoinType
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  LeftOuter
                  {-# LINE 5987 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  LeftOuter
                  {-# LINE 5992 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 5997 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 6002 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_JoinType_RightOuter :: T_JoinType 
sem_JoinType_RightOuter  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: JoinType
              _lhsOoriginalTree :: JoinType
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  RightOuter
                  {-# LINE 6014 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  RightOuter
                  {-# LINE 6019 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 6024 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 6029 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- Language ----------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Plpgsql:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Sql:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data Language  = Plpgsql 
               | Sql 
               deriving ( Data,Eq,Show,Typeable)
-- cata
sem_Language :: Language  ->
                T_Language 
sem_Language (Plpgsql )  =
    (sem_Language_Plpgsql )
sem_Language (Sql )  =
    (sem_Language_Sql )
-- semantic domain
type T_Language  = Catalog ->
                   LocalBindings ->
                   ( Language,Language)
data Inh_Language  = Inh_Language {cat_Inh_Language :: Catalog,lib_Inh_Language :: LocalBindings}
data Syn_Language  = Syn_Language {annotatedTree_Syn_Language :: Language,originalTree_Syn_Language :: Language}
wrap_Language :: T_Language  ->
                 Inh_Language  ->
                 Syn_Language 
wrap_Language sem (Inh_Language _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_Language _lhsOannotatedTree _lhsOoriginalTree ))
sem_Language_Plpgsql :: T_Language 
sem_Language_Plpgsql  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Language
              _lhsOoriginalTree :: Language
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Plpgsql
                  {-# LINE 6083 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Plpgsql
                  {-# LINE 6088 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 6093 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 6098 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_Language_Sql :: T_Language 
sem_Language_Sql  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Language
              _lhsOoriginalTree :: Language
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Sql
                  {-# LINE 6110 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Sql
                  {-# LINE 6115 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 6120 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 6125 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- LiftFlavour -------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative LiftAll:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative LiftAny:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data LiftFlavour  = LiftAll 
                  | LiftAny 
                  deriving ( Data,Eq,Show,Typeable)
-- cata
sem_LiftFlavour :: LiftFlavour  ->
                   T_LiftFlavour 
sem_LiftFlavour (LiftAll )  =
    (sem_LiftFlavour_LiftAll )
sem_LiftFlavour (LiftAny )  =
    (sem_LiftFlavour_LiftAny )
-- semantic domain
type T_LiftFlavour  = Catalog ->
                      LocalBindings ->
                      ( LiftFlavour,LiftFlavour)
data Inh_LiftFlavour  = Inh_LiftFlavour {cat_Inh_LiftFlavour :: Catalog,lib_Inh_LiftFlavour :: LocalBindings}
data Syn_LiftFlavour  = Syn_LiftFlavour {annotatedTree_Syn_LiftFlavour :: LiftFlavour,originalTree_Syn_LiftFlavour :: LiftFlavour}
wrap_LiftFlavour :: T_LiftFlavour  ->
                    Inh_LiftFlavour  ->
                    Syn_LiftFlavour 
wrap_LiftFlavour sem (Inh_LiftFlavour _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_LiftFlavour _lhsOannotatedTree _lhsOoriginalTree ))
sem_LiftFlavour_LiftAll :: T_LiftFlavour 
sem_LiftFlavour_LiftAll  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: LiftFlavour
              _lhsOoriginalTree :: LiftFlavour
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  LiftAll
                  {-# LINE 6179 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  LiftAll
                  {-# LINE 6184 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 6189 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 6194 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_LiftFlavour_LiftAny :: T_LiftFlavour 
sem_LiftFlavour_LiftAny  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: LiftFlavour
              _lhsOoriginalTree :: LiftFlavour
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  LiftAny
                  {-# LINE 6206 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  LiftAny
                  {-# LINE 6211 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 6216 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 6221 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- MaybeBoolExpression -----------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Just:
         child just           : Expression 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nothing:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type MaybeBoolExpression  = (Maybe (Expression))
-- cata
sem_MaybeBoolExpression :: MaybeBoolExpression  ->
                           T_MaybeBoolExpression 
sem_MaybeBoolExpression (Prelude.Just x )  =
    (sem_MaybeBoolExpression_Just (sem_Expression x ) )
sem_MaybeBoolExpression Prelude.Nothing  =
    sem_MaybeBoolExpression_Nothing
-- semantic domain
type T_MaybeBoolExpression  = Catalog ->
                              LocalBindings ->
                              ( MaybeBoolExpression,MaybeBoolExpression)
data Inh_MaybeBoolExpression  = Inh_MaybeBoolExpression {cat_Inh_MaybeBoolExpression :: Catalog,lib_Inh_MaybeBoolExpression :: LocalBindings}
data Syn_MaybeBoolExpression  = Syn_MaybeBoolExpression {annotatedTree_Syn_MaybeBoolExpression :: MaybeBoolExpression,originalTree_Syn_MaybeBoolExpression :: MaybeBoolExpression}
wrap_MaybeBoolExpression :: T_MaybeBoolExpression  ->
                            Inh_MaybeBoolExpression  ->
                            Syn_MaybeBoolExpression 
wrap_MaybeBoolExpression sem (Inh_MaybeBoolExpression _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_MaybeBoolExpression _lhsOannotatedTree _lhsOoriginalTree ))
sem_MaybeBoolExpression_Just :: T_Expression  ->
                                T_MaybeBoolExpression 
sem_MaybeBoolExpression_Just just_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: MaybeBoolExpression
              _lhsOoriginalTree :: MaybeBoolExpression
              _justOcat :: Catalog
              _justOlib :: LocalBindings
              _justIannotatedTree :: Expression
              _justIliftedColumnName :: String
              _justIoriginalTree :: Expression
              -- "./TypeChecking/Misc.ag"(line 74, column 9)
              _lhsOannotatedTree =
                  {-# LINE 74 "./TypeChecking/Misc.ag" #-}
                  if getTypeAnnotation _justIannotatedTree `notElem` [typeBool, TypeCheckFailed]
                    then Just $ updateAnnotation ((TypeErrorA ExpressionMustBeBool) :)
                                  _justIannotatedTree
                    else Just $ _justIannotatedTree
                  {-# LINE 6283 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Just _justIannotatedTree
                  {-# LINE 6288 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Just _justIoriginalTree
                  {-# LINE 6293 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 6298 "AstInternal.hs" #-}
              -- copy rule (down)
              _justOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 6303 "AstInternal.hs" #-}
              -- copy rule (down)
              _justOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 6308 "AstInternal.hs" #-}
              ( _justIannotatedTree,_justIliftedColumnName,_justIoriginalTree) =
                  (just_ _justOcat _justOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_MaybeBoolExpression_Nothing :: T_MaybeBoolExpression 
sem_MaybeBoolExpression_Nothing  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: MaybeBoolExpression
              _lhsOoriginalTree :: MaybeBoolExpression
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Nothing
                  {-# LINE 6322 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Nothing
                  {-# LINE 6327 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 6332 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 6337 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- MaybeExpression ---------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Just:
         child just           : Expression 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nothing:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type MaybeExpression  = (Maybe (Expression))
-- cata
sem_MaybeExpression :: MaybeExpression  ->
                       T_MaybeExpression 
sem_MaybeExpression (Prelude.Just x )  =
    (sem_MaybeExpression_Just (sem_Expression x ) )
sem_MaybeExpression Prelude.Nothing  =
    sem_MaybeExpression_Nothing
-- semantic domain
type T_MaybeExpression  = Catalog ->
                          LocalBindings ->
                          ( MaybeExpression,MaybeExpression)
data Inh_MaybeExpression  = Inh_MaybeExpression {cat_Inh_MaybeExpression :: Catalog,lib_Inh_MaybeExpression :: LocalBindings}
data Syn_MaybeExpression  = Syn_MaybeExpression {annotatedTree_Syn_MaybeExpression :: MaybeExpression,originalTree_Syn_MaybeExpression :: MaybeExpression}
wrap_MaybeExpression :: T_MaybeExpression  ->
                        Inh_MaybeExpression  ->
                        Syn_MaybeExpression 
wrap_MaybeExpression sem (Inh_MaybeExpression _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_MaybeExpression _lhsOannotatedTree _lhsOoriginalTree ))
sem_MaybeExpression_Just :: T_Expression  ->
                            T_MaybeExpression 
sem_MaybeExpression_Just just_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: MaybeExpression
              _lhsOoriginalTree :: MaybeExpression
              _justOcat :: Catalog
              _justOlib :: LocalBindings
              _justIannotatedTree :: Expression
              _justIliftedColumnName :: String
              _justIoriginalTree :: Expression
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Just _justIannotatedTree
                  {-# LINE 6396 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Just _justIoriginalTree
                  {-# LINE 6401 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 6406 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 6411 "AstInternal.hs" #-}
              -- copy rule (down)
              _justOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 6416 "AstInternal.hs" #-}
              -- copy rule (down)
              _justOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 6421 "AstInternal.hs" #-}
              ( _justIannotatedTree,_justIliftedColumnName,_justIoriginalTree) =
                  (just_ _justOcat _justOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_MaybeExpression_Nothing :: T_MaybeExpression 
sem_MaybeExpression_Nothing  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: MaybeExpression
              _lhsOoriginalTree :: MaybeExpression
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Nothing
                  {-# LINE 6435 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Nothing
                  {-# LINE 6440 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 6445 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 6450 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- MaybeSelectList ---------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         listType             : Maybe [(String,Type)]
         originalTree         : SELF 
   alternatives:
      alternative Just:
         child just           : SelectList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nothing:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type MaybeSelectList  = (Maybe (SelectList))
-- cata
sem_MaybeSelectList :: MaybeSelectList  ->
                       T_MaybeSelectList 
sem_MaybeSelectList (Prelude.Just x )  =
    (sem_MaybeSelectList_Just (sem_SelectList x ) )
sem_MaybeSelectList Prelude.Nothing  =
    sem_MaybeSelectList_Nothing
-- semantic domain
type T_MaybeSelectList  = Catalog ->
                          LocalBindings ->
                          ( MaybeSelectList,(Maybe [(String,Type)]),MaybeSelectList)
data Inh_MaybeSelectList  = Inh_MaybeSelectList {cat_Inh_MaybeSelectList :: Catalog,lib_Inh_MaybeSelectList :: LocalBindings}
data Syn_MaybeSelectList  = Syn_MaybeSelectList {annotatedTree_Syn_MaybeSelectList :: MaybeSelectList,listType_Syn_MaybeSelectList :: Maybe [(String,Type)],originalTree_Syn_MaybeSelectList :: MaybeSelectList}
wrap_MaybeSelectList :: T_MaybeSelectList  ->
                        Inh_MaybeSelectList  ->
                        Syn_MaybeSelectList 
wrap_MaybeSelectList sem (Inh_MaybeSelectList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOlistType,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_MaybeSelectList _lhsOannotatedTree _lhsOlistType _lhsOoriginalTree ))
sem_MaybeSelectList_Just :: T_SelectList  ->
                            T_MaybeSelectList 
sem_MaybeSelectList_Just just_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOlistType :: (Maybe [(String,Type)])
              _lhsOannotatedTree :: MaybeSelectList
              _lhsOoriginalTree :: MaybeSelectList
              _justOcat :: Catalog
              _justOlib :: LocalBindings
              _justIannotatedTree :: SelectList
              _justIlibUpdates :: ([LocalBindingsUpdate])
              _justIlistType :: ([(String,Type)])
              _justIoriginalTree :: SelectList
              -- "./TypeChecking/SelectLists.ag"(line 25, column 12)
              _lhsOlistType =
                  {-# LINE 25 "./TypeChecking/SelectLists.ag" #-}
                  Just _justIlistType
                  {-# LINE 6512 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Just _justIannotatedTree
                  {-# LINE 6517 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Just _justIoriginalTree
                  {-# LINE 6522 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 6527 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 6532 "AstInternal.hs" #-}
              -- copy rule (down)
              _justOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 6537 "AstInternal.hs" #-}
              -- copy rule (down)
              _justOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 6542 "AstInternal.hs" #-}
              ( _justIannotatedTree,_justIlibUpdates,_justIlistType,_justIoriginalTree) =
                  (just_ _justOcat _justOlib )
          in  ( _lhsOannotatedTree,_lhsOlistType,_lhsOoriginalTree)))
sem_MaybeSelectList_Nothing :: T_MaybeSelectList 
sem_MaybeSelectList_Nothing  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOlistType :: (Maybe [(String,Type)])
              _lhsOannotatedTree :: MaybeSelectList
              _lhsOoriginalTree :: MaybeSelectList
              -- "./TypeChecking/SelectLists.ag"(line 26, column 15)
              _lhsOlistType =
                  {-# LINE 26 "./TypeChecking/SelectLists.ag" #-}
                  Nothing
                  {-# LINE 6557 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Nothing
                  {-# LINE 6562 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Nothing
                  {-# LINE 6567 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 6572 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 6577 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOlistType,_lhsOoriginalTree)))
-- Natural -----------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Natural:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Unnatural:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data Natural  = Natural 
              | Unnatural 
              deriving ( Data,Eq,Show,Typeable)
-- cata
sem_Natural :: Natural  ->
               T_Natural 
sem_Natural (Natural )  =
    (sem_Natural_Natural )
sem_Natural (Unnatural )  =
    (sem_Natural_Unnatural )
-- semantic domain
type T_Natural  = Catalog ->
                  LocalBindings ->
                  ( Natural,Natural)
data Inh_Natural  = Inh_Natural {cat_Inh_Natural :: Catalog,lib_Inh_Natural :: LocalBindings}
data Syn_Natural  = Syn_Natural {annotatedTree_Syn_Natural :: Natural,originalTree_Syn_Natural :: Natural}
wrap_Natural :: T_Natural  ->
                Inh_Natural  ->
                Syn_Natural 
wrap_Natural sem (Inh_Natural _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_Natural _lhsOannotatedTree _lhsOoriginalTree ))
sem_Natural_Natural :: T_Natural 
sem_Natural_Natural  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Natural
              _lhsOoriginalTree :: Natural
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Natural
                  {-# LINE 6631 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Natural
                  {-# LINE 6636 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 6641 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 6646 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_Natural_Unnatural :: T_Natural 
sem_Natural_Unnatural  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Natural
              _lhsOoriginalTree :: Natural
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Unnatural
                  {-# LINE 6658 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Unnatural
                  {-# LINE 6663 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 6668 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 6673 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- OnExpr ------------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Just:
         child just           : JoinExpression 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nothing:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type OnExpr  = (Maybe (JoinExpression))
-- cata
sem_OnExpr :: OnExpr  ->
              T_OnExpr 
sem_OnExpr (Prelude.Just x )  =
    (sem_OnExpr_Just (sem_JoinExpression x ) )
sem_OnExpr Prelude.Nothing  =
    sem_OnExpr_Nothing
-- semantic domain
type T_OnExpr  = Catalog ->
                 LocalBindings ->
                 ( OnExpr,OnExpr)
data Inh_OnExpr  = Inh_OnExpr {cat_Inh_OnExpr :: Catalog,lib_Inh_OnExpr :: LocalBindings}
data Syn_OnExpr  = Syn_OnExpr {annotatedTree_Syn_OnExpr :: OnExpr,originalTree_Syn_OnExpr :: OnExpr}
wrap_OnExpr :: T_OnExpr  ->
               Inh_OnExpr  ->
               Syn_OnExpr 
wrap_OnExpr sem (Inh_OnExpr _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_OnExpr _lhsOannotatedTree _lhsOoriginalTree ))
sem_OnExpr_Just :: T_JoinExpression  ->
                   T_OnExpr 
sem_OnExpr_Just just_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: OnExpr
              _lhsOoriginalTree :: OnExpr
              _justOcat :: Catalog
              _justOlib :: LocalBindings
              _justIannotatedTree :: JoinExpression
              _justIoriginalTree :: JoinExpression
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Just _justIannotatedTree
                  {-# LINE 6731 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Just _justIoriginalTree
                  {-# LINE 6736 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 6741 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 6746 "AstInternal.hs" #-}
              -- copy rule (down)
              _justOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 6751 "AstInternal.hs" #-}
              -- copy rule (down)
              _justOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 6756 "AstInternal.hs" #-}
              ( _justIannotatedTree,_justIoriginalTree) =
                  (just_ _justOcat _justOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_OnExpr_Nothing :: T_OnExpr 
sem_OnExpr_Nothing  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: OnExpr
              _lhsOoriginalTree :: OnExpr
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Nothing
                  {-# LINE 6770 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Nothing
                  {-# LINE 6775 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 6780 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 6785 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- ParamDef ----------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         namedType            : Type
         originalTree         : SELF 
         paramName            : String
   alternatives:
      alternative ParamDef:
         child ann            : {Annotation}
         child name           : {String}
         child typ            : TypeName 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative ParamDefTp:
         child ann            : {Annotation}
         child typ            : TypeName 
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data ParamDef  = ParamDef (Annotation) (String) (TypeName) 
               | ParamDefTp (Annotation) (TypeName) 
               deriving ( Data,Eq,Show,Typeable)
-- cata
sem_ParamDef :: ParamDef  ->
                T_ParamDef 
sem_ParamDef (ParamDef _ann _name _typ )  =
    (sem_ParamDef_ParamDef _ann _name (sem_TypeName _typ ) )
sem_ParamDef (ParamDefTp _ann _typ )  =
    (sem_ParamDef_ParamDefTp _ann (sem_TypeName _typ ) )
-- semantic domain
type T_ParamDef  = Catalog ->
                   LocalBindings ->
                   ( ParamDef,Type,ParamDef,String)
data Inh_ParamDef  = Inh_ParamDef {cat_Inh_ParamDef :: Catalog,lib_Inh_ParamDef :: LocalBindings}
data Syn_ParamDef  = Syn_ParamDef {annotatedTree_Syn_ParamDef :: ParamDef,namedType_Syn_ParamDef :: Type,originalTree_Syn_ParamDef :: ParamDef,paramName_Syn_ParamDef :: String}
wrap_ParamDef :: T_ParamDef  ->
                 Inh_ParamDef  ->
                 Syn_ParamDef 
wrap_ParamDef sem (Inh_ParamDef _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOnamedType,_lhsOoriginalTree,_lhsOparamName) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_ParamDef _lhsOannotatedTree _lhsOnamedType _lhsOoriginalTree _lhsOparamName ))
sem_ParamDef_ParamDef :: Annotation ->
                         String ->
                         T_TypeName  ->
                         T_ParamDef 
sem_ParamDef_ParamDef ann_ name_ typ_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOnamedType :: Type
              _lhsOparamName :: String
              _lhsOannotatedTree :: ParamDef
              _lhsOoriginalTree :: ParamDef
              _typOcat :: Catalog
              _typOlib :: LocalBindings
              _typIannotatedTree :: TypeName
              _typInamedType :: Type
              _typIoriginalTree :: TypeName
              -- "./TypeChecking/CreateFunction.ag"(line 56, column 9)
              _lhsOnamedType =
                  {-# LINE 56 "./TypeChecking/CreateFunction.ag" #-}
                  _typInamedType
                  {-# LINE 6856 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateFunction.ag"(line 58, column 9)
              _lhsOparamName =
                  {-# LINE 58 "./TypeChecking/CreateFunction.ag" #-}
                  name_
                  {-# LINE 6861 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  ParamDef ann_ name_ _typIannotatedTree
                  {-# LINE 6866 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  ParamDef ann_ name_ _typIoriginalTree
                  {-# LINE 6871 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 6876 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 6881 "AstInternal.hs" #-}
              -- copy rule (down)
              _typOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 6886 "AstInternal.hs" #-}
              -- copy rule (down)
              _typOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 6891 "AstInternal.hs" #-}
              ( _typIannotatedTree,_typInamedType,_typIoriginalTree) =
                  (typ_ _typOcat _typOlib )
          in  ( _lhsOannotatedTree,_lhsOnamedType,_lhsOoriginalTree,_lhsOparamName)))
sem_ParamDef_ParamDefTp :: Annotation ->
                           T_TypeName  ->
                           T_ParamDef 
sem_ParamDef_ParamDefTp ann_ typ_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOnamedType :: Type
              _lhsOparamName :: String
              _lhsOannotatedTree :: ParamDef
              _lhsOoriginalTree :: ParamDef
              _typOcat :: Catalog
              _typOlib :: LocalBindings
              _typIannotatedTree :: TypeName
              _typInamedType :: Type
              _typIoriginalTree :: TypeName
              -- "./TypeChecking/CreateFunction.ag"(line 56, column 9)
              _lhsOnamedType =
                  {-# LINE 56 "./TypeChecking/CreateFunction.ag" #-}
                  _typInamedType
                  {-# LINE 6914 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateFunction.ag"(line 60, column 9)
              _lhsOparamName =
                  {-# LINE 60 "./TypeChecking/CreateFunction.ag" #-}
                  ""
                  {-# LINE 6919 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  ParamDefTp ann_ _typIannotatedTree
                  {-# LINE 6924 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  ParamDefTp ann_ _typIoriginalTree
                  {-# LINE 6929 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 6934 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 6939 "AstInternal.hs" #-}
              -- copy rule (down)
              _typOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 6944 "AstInternal.hs" #-}
              -- copy rule (down)
              _typOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 6949 "AstInternal.hs" #-}
              ( _typIannotatedTree,_typInamedType,_typIoriginalTree) =
                  (typ_ _typOcat _typOlib )
          in  ( _lhsOannotatedTree,_lhsOnamedType,_lhsOoriginalTree,_lhsOparamName)))
-- ParamDefList ------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
         params               : [(String, Type)]
   alternatives:
      alternative Cons:
         child hd             : ParamDef 
         child tl             : ParamDefList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type ParamDefList  = [(ParamDef)]
-- cata
sem_ParamDefList :: ParamDefList  ->
                    T_ParamDefList 
sem_ParamDefList list  =
    (Prelude.foldr sem_ParamDefList_Cons sem_ParamDefList_Nil (Prelude.map sem_ParamDef list) )
-- semantic domain
type T_ParamDefList  = Catalog ->
                       LocalBindings ->
                       ( ParamDefList,ParamDefList,([(String, Type)]))
data Inh_ParamDefList  = Inh_ParamDefList {cat_Inh_ParamDefList :: Catalog,lib_Inh_ParamDefList :: LocalBindings}
data Syn_ParamDefList  = Syn_ParamDefList {annotatedTree_Syn_ParamDefList :: ParamDefList,originalTree_Syn_ParamDefList :: ParamDefList,params_Syn_ParamDefList :: [(String, Type)]}
wrap_ParamDefList :: T_ParamDefList  ->
                     Inh_ParamDefList  ->
                     Syn_ParamDefList 
wrap_ParamDefList sem (Inh_ParamDefList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOparams) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_ParamDefList _lhsOannotatedTree _lhsOoriginalTree _lhsOparams ))
sem_ParamDefList_Cons :: T_ParamDef  ->
                         T_ParamDefList  ->
                         T_ParamDefList 
sem_ParamDefList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOparams :: ([(String, Type)])
              _lhsOannotatedTree :: ParamDefList
              _lhsOoriginalTree :: ParamDefList
              _hdOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _hdIannotatedTree :: ParamDef
              _hdInamedType :: Type
              _hdIoriginalTree :: ParamDef
              _hdIparamName :: String
              _tlIannotatedTree :: ParamDefList
              _tlIoriginalTree :: ParamDefList
              _tlIparams :: ([(String, Type)])
              -- "./TypeChecking/CreateFunction.ag"(line 64, column 13)
              _lhsOparams =
                  {-# LINE 64 "./TypeChecking/CreateFunction.ag" #-}
                  ((_hdIparamName, _hdInamedType) : _tlIparams)
                  {-# LINE 7018 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 7023 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 7028 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 7033 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 7038 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 7043 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 7048 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 7053 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 7058 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdInamedType,_hdIoriginalTree,_hdIparamName) =
                  (hd_ _hdOcat _hdOlib )
              ( _tlIannotatedTree,_tlIoriginalTree,_tlIparams) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOparams)))
sem_ParamDefList_Nil :: T_ParamDefList 
sem_ParamDefList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOparams :: ([(String, Type)])
              _lhsOannotatedTree :: ParamDefList
              _lhsOoriginalTree :: ParamDefList
              -- "./TypeChecking/CreateFunction.ag"(line 63, column 12)
              _lhsOparams =
                  {-# LINE 63 "./TypeChecking/CreateFunction.ag" #-}
                  []
                  {-# LINE 7075 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 7080 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 7085 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 7090 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 7095 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOparams)))
-- RaiseType ---------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative RError:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative RException:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative RNotice:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data RaiseType  = RError 
                | RException 
                | RNotice 
                deriving ( Data,Eq,Show,Typeable)
-- cata
sem_RaiseType :: RaiseType  ->
                 T_RaiseType 
sem_RaiseType (RError )  =
    (sem_RaiseType_RError )
sem_RaiseType (RException )  =
    (sem_RaiseType_RException )
sem_RaiseType (RNotice )  =
    (sem_RaiseType_RNotice )
-- semantic domain
type T_RaiseType  = Catalog ->
                    LocalBindings ->
                    ( RaiseType,RaiseType)
data Inh_RaiseType  = Inh_RaiseType {cat_Inh_RaiseType :: Catalog,lib_Inh_RaiseType :: LocalBindings}
data Syn_RaiseType  = Syn_RaiseType {annotatedTree_Syn_RaiseType :: RaiseType,originalTree_Syn_RaiseType :: RaiseType}
wrap_RaiseType :: T_RaiseType  ->
                  Inh_RaiseType  ->
                  Syn_RaiseType 
wrap_RaiseType sem (Inh_RaiseType _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_RaiseType _lhsOannotatedTree _lhsOoriginalTree ))
sem_RaiseType_RError :: T_RaiseType 
sem_RaiseType_RError  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: RaiseType
              _lhsOoriginalTree :: RaiseType
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  RError
                  {-# LINE 7156 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  RError
                  {-# LINE 7161 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 7166 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 7171 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_RaiseType_RException :: T_RaiseType 
sem_RaiseType_RException  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: RaiseType
              _lhsOoriginalTree :: RaiseType
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  RException
                  {-# LINE 7183 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  RException
                  {-# LINE 7188 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 7193 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 7198 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_RaiseType_RNotice :: T_RaiseType 
sem_RaiseType_RNotice  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: RaiseType
              _lhsOoriginalTree :: RaiseType
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  RNotice
                  {-# LINE 7210 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  RNotice
                  {-# LINE 7215 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 7220 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 7225 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- RestartIdentity ---------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative ContinueIdentity:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative RestartIdentity:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data RestartIdentity  = ContinueIdentity 
                      | RestartIdentity 
                      deriving ( Data,Eq,Show,Typeable)
-- cata
sem_RestartIdentity :: RestartIdentity  ->
                       T_RestartIdentity 
sem_RestartIdentity (ContinueIdentity )  =
    (sem_RestartIdentity_ContinueIdentity )
sem_RestartIdentity (RestartIdentity )  =
    (sem_RestartIdentity_RestartIdentity )
-- semantic domain
type T_RestartIdentity  = Catalog ->
                          LocalBindings ->
                          ( RestartIdentity,RestartIdentity)
data Inh_RestartIdentity  = Inh_RestartIdentity {cat_Inh_RestartIdentity :: Catalog,lib_Inh_RestartIdentity :: LocalBindings}
data Syn_RestartIdentity  = Syn_RestartIdentity {annotatedTree_Syn_RestartIdentity :: RestartIdentity,originalTree_Syn_RestartIdentity :: RestartIdentity}
wrap_RestartIdentity :: T_RestartIdentity  ->
                        Inh_RestartIdentity  ->
                        Syn_RestartIdentity 
wrap_RestartIdentity sem (Inh_RestartIdentity _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_RestartIdentity _lhsOannotatedTree _lhsOoriginalTree ))
sem_RestartIdentity_ContinueIdentity :: T_RestartIdentity 
sem_RestartIdentity_ContinueIdentity  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: RestartIdentity
              _lhsOoriginalTree :: RestartIdentity
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  ContinueIdentity
                  {-# LINE 7279 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  ContinueIdentity
                  {-# LINE 7284 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 7289 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 7294 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_RestartIdentity_RestartIdentity :: T_RestartIdentity 
sem_RestartIdentity_RestartIdentity  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: RestartIdentity
              _lhsOoriginalTree :: RestartIdentity
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  RestartIdentity
                  {-# LINE 7306 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  RestartIdentity
                  {-# LINE 7311 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 7316 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 7321 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- Root --------------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
         producedCat          : Catalog
         producedLib          : LocalBindings
   alternatives:
      alternative Root:
         child statements     : StatementList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data Root  = Root (StatementList) 
           deriving ( Show)
-- cata
sem_Root :: Root  ->
            T_Root 
sem_Root (Root _statements )  =
    (sem_Root_Root (sem_StatementList _statements ) )
-- semantic domain
type T_Root  = Catalog ->
               LocalBindings ->
               ( Root,Root,Catalog,LocalBindings)
data Inh_Root  = Inh_Root {cat_Inh_Root :: Catalog,lib_Inh_Root :: LocalBindings}
data Syn_Root  = Syn_Root {annotatedTree_Syn_Root :: Root,originalTree_Syn_Root :: Root,producedCat_Syn_Root :: Catalog,producedLib_Syn_Root :: LocalBindings}
wrap_Root :: T_Root  ->
             Inh_Root  ->
             Syn_Root 
wrap_Root sem (Inh_Root _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOproducedCat,_lhsOproducedLib) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_Root _lhsOannotatedTree _lhsOoriginalTree _lhsOproducedCat _lhsOproducedLib ))
sem_Root_Root :: T_StatementList  ->
                 T_Root 
sem_Root_Root statements_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _statementsOcatUpdates :: ([CatalogUpdate])
              _statementsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Root
              _lhsOoriginalTree :: Root
              _lhsOproducedCat :: Catalog
              _lhsOproducedLib :: LocalBindings
              _statementsOcat :: Catalog
              _statementsOlib :: LocalBindings
              _statementsIannotatedTree :: StatementList
              _statementsIoriginalTree :: StatementList
              _statementsIproducedCat :: Catalog
              _statementsIproducedLib :: LocalBindings
              -- "./TypeChecking/Statements.ag"(line 80, column 12)
              _statementsOcatUpdates =
                  {-# LINE 80 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 7382 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 81, column 12)
              _statementsOlibUpdates =
                  {-# LINE 81 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 7387 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Root _statementsIannotatedTree
                  {-# LINE 7392 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Root _statementsIoriginalTree
                  {-# LINE 7397 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 7402 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 7407 "AstInternal.hs" #-}
              -- copy rule (up)
              _lhsOproducedCat =
                  {-# LINE 27 "./TypeChecking/Statements.ag" #-}
                  _statementsIproducedCat
                  {-# LINE 7412 "AstInternal.hs" #-}
              -- copy rule (up)
              _lhsOproducedLib =
                  {-# LINE 28 "./TypeChecking/Statements.ag" #-}
                  _statementsIproducedLib
                  {-# LINE 7417 "AstInternal.hs" #-}
              -- copy rule (down)
              _statementsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 7422 "AstInternal.hs" #-}
              -- copy rule (down)
              _statementsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 7427 "AstInternal.hs" #-}
              ( _statementsIannotatedTree,_statementsIoriginalTree,_statementsIproducedCat,_statementsIproducedLib) =
                  (statements_ _statementsOcat _statementsOcatUpdates _statementsOlib _statementsOlibUpdates )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOproducedCat,_lhsOproducedLib)))
-- RowConstraint -----------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative NotNullConstraint:
         child ann            : {Annotation}
         child name           : {String}
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative NullConstraint:
         child ann            : {Annotation}
         child name           : {String}
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative RowCheckConstraint:
         child ann            : {Annotation}
         child name           : {String}
         child expression     : Expression 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative RowPrimaryKeyConstraint:
         child ann            : {Annotation}
         child name           : {String}
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative RowReferenceConstraint:
         child ann            : {Annotation}
         child name           : {String}
         child table          : {String}
         child att            : {Maybe String}
         child onUpdate       : Cascade 
         child onDelete       : Cascade 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative RowUniqueConstraint:
         child ann            : {Annotation}
         child name           : {String}
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data RowConstraint  = NotNullConstraint (Annotation) (String) 
                    | NullConstraint (Annotation) (String) 
                    | RowCheckConstraint (Annotation) (String) (Expression) 
                    | RowPrimaryKeyConstraint (Annotation) (String) 
                    | RowReferenceConstraint (Annotation) (String) (String) (Maybe String) (Cascade) (Cascade) 
                    | RowUniqueConstraint (Annotation) (String) 
                    deriving ( Data,Eq,Show,Typeable)
-- cata
sem_RowConstraint :: RowConstraint  ->
                     T_RowConstraint 
sem_RowConstraint (NotNullConstraint _ann _name )  =
    (sem_RowConstraint_NotNullConstraint _ann _name )
sem_RowConstraint (NullConstraint _ann _name )  =
    (sem_RowConstraint_NullConstraint _ann _name )
sem_RowConstraint (RowCheckConstraint _ann _name _expression )  =
    (sem_RowConstraint_RowCheckConstraint _ann _name (sem_Expression _expression ) )
sem_RowConstraint (RowPrimaryKeyConstraint _ann _name )  =
    (sem_RowConstraint_RowPrimaryKeyConstraint _ann _name )
sem_RowConstraint (RowReferenceConstraint _ann _name _table _att _onUpdate _onDelete )  =
    (sem_RowConstraint_RowReferenceConstraint _ann _name _table _att (sem_Cascade _onUpdate ) (sem_Cascade _onDelete ) )
sem_RowConstraint (RowUniqueConstraint _ann _name )  =
    (sem_RowConstraint_RowUniqueConstraint _ann _name )
-- semantic domain
type T_RowConstraint  = Catalog ->
                        LocalBindings ->
                        ( RowConstraint,RowConstraint)
data Inh_RowConstraint  = Inh_RowConstraint {cat_Inh_RowConstraint :: Catalog,lib_Inh_RowConstraint :: LocalBindings}
data Syn_RowConstraint  = Syn_RowConstraint {annotatedTree_Syn_RowConstraint :: RowConstraint,originalTree_Syn_RowConstraint :: RowConstraint}
wrap_RowConstraint :: T_RowConstraint  ->
                      Inh_RowConstraint  ->
                      Syn_RowConstraint 
wrap_RowConstraint sem (Inh_RowConstraint _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_RowConstraint _lhsOannotatedTree _lhsOoriginalTree ))
sem_RowConstraint_NotNullConstraint :: Annotation ->
                                       String ->
                                       T_RowConstraint 
sem_RowConstraint_NotNullConstraint ann_ name_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: RowConstraint
              _lhsOoriginalTree :: RowConstraint
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  NotNullConstraint ann_ name_
                  {-# LINE 7530 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  NotNullConstraint ann_ name_
                  {-# LINE 7535 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 7540 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 7545 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_RowConstraint_NullConstraint :: Annotation ->
                                    String ->
                                    T_RowConstraint 
sem_RowConstraint_NullConstraint ann_ name_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: RowConstraint
              _lhsOoriginalTree :: RowConstraint
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  NullConstraint ann_ name_
                  {-# LINE 7559 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  NullConstraint ann_ name_
                  {-# LINE 7564 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 7569 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 7574 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_RowConstraint_RowCheckConstraint :: Annotation ->
                                        String ->
                                        T_Expression  ->
                                        T_RowConstraint 
sem_RowConstraint_RowCheckConstraint ann_ name_ expression_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: RowConstraint
              _lhsOoriginalTree :: RowConstraint
              _expressionOcat :: Catalog
              _expressionOlib :: LocalBindings
              _expressionIannotatedTree :: Expression
              _expressionIliftedColumnName :: String
              _expressionIoriginalTree :: Expression
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  RowCheckConstraint ann_ name_ _expressionIannotatedTree
                  {-# LINE 7594 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  RowCheckConstraint ann_ name_ _expressionIoriginalTree
                  {-# LINE 7599 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 7604 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 7609 "AstInternal.hs" #-}
              -- copy rule (down)
              _expressionOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 7614 "AstInternal.hs" #-}
              -- copy rule (down)
              _expressionOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 7619 "AstInternal.hs" #-}
              ( _expressionIannotatedTree,_expressionIliftedColumnName,_expressionIoriginalTree) =
                  (expression_ _expressionOcat _expressionOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_RowConstraint_RowPrimaryKeyConstraint :: Annotation ->
                                             String ->
                                             T_RowConstraint 
sem_RowConstraint_RowPrimaryKeyConstraint ann_ name_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: RowConstraint
              _lhsOoriginalTree :: RowConstraint
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  RowPrimaryKeyConstraint ann_ name_
                  {-# LINE 7635 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  RowPrimaryKeyConstraint ann_ name_
                  {-# LINE 7640 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 7645 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 7650 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_RowConstraint_RowReferenceConstraint :: Annotation ->
                                            String ->
                                            String ->
                                            (Maybe String) ->
                                            T_Cascade  ->
                                            T_Cascade  ->
                                            T_RowConstraint 
sem_RowConstraint_RowReferenceConstraint ann_ name_ table_ att_ onUpdate_ onDelete_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: RowConstraint
              _lhsOoriginalTree :: RowConstraint
              _onUpdateOcat :: Catalog
              _onUpdateOlib :: LocalBindings
              _onDeleteOcat :: Catalog
              _onDeleteOlib :: LocalBindings
              _onUpdateIannotatedTree :: Cascade
              _onUpdateIoriginalTree :: Cascade
              _onDeleteIannotatedTree :: Cascade
              _onDeleteIoriginalTree :: Cascade
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  RowReferenceConstraint ann_ name_ table_ att_ _onUpdateIannotatedTree _onDeleteIannotatedTree
                  {-# LINE 7676 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  RowReferenceConstraint ann_ name_ table_ att_ _onUpdateIoriginalTree _onDeleteIoriginalTree
                  {-# LINE 7681 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 7686 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 7691 "AstInternal.hs" #-}
              -- copy rule (down)
              _onUpdateOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 7696 "AstInternal.hs" #-}
              -- copy rule (down)
              _onUpdateOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 7701 "AstInternal.hs" #-}
              -- copy rule (down)
              _onDeleteOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 7706 "AstInternal.hs" #-}
              -- copy rule (down)
              _onDeleteOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 7711 "AstInternal.hs" #-}
              ( _onUpdateIannotatedTree,_onUpdateIoriginalTree) =
                  (onUpdate_ _onUpdateOcat _onUpdateOlib )
              ( _onDeleteIannotatedTree,_onDeleteIoriginalTree) =
                  (onDelete_ _onDeleteOcat _onDeleteOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_RowConstraint_RowUniqueConstraint :: Annotation ->
                                         String ->
                                         T_RowConstraint 
sem_RowConstraint_RowUniqueConstraint ann_ name_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: RowConstraint
              _lhsOoriginalTree :: RowConstraint
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  RowUniqueConstraint ann_ name_
                  {-# LINE 7729 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  RowUniqueConstraint ann_ name_
                  {-# LINE 7734 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 7739 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 7744 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- RowConstraintList -------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Cons:
         child hd             : RowConstraint 
         child tl             : RowConstraintList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type RowConstraintList  = [(RowConstraint)]
-- cata
sem_RowConstraintList :: RowConstraintList  ->
                         T_RowConstraintList 
sem_RowConstraintList list  =
    (Prelude.foldr sem_RowConstraintList_Cons sem_RowConstraintList_Nil (Prelude.map sem_RowConstraint list) )
-- semantic domain
type T_RowConstraintList  = Catalog ->
                            LocalBindings ->
                            ( RowConstraintList,RowConstraintList)
data Inh_RowConstraintList  = Inh_RowConstraintList {cat_Inh_RowConstraintList :: Catalog,lib_Inh_RowConstraintList :: LocalBindings}
data Syn_RowConstraintList  = Syn_RowConstraintList {annotatedTree_Syn_RowConstraintList :: RowConstraintList,originalTree_Syn_RowConstraintList :: RowConstraintList}
wrap_RowConstraintList :: T_RowConstraintList  ->
                          Inh_RowConstraintList  ->
                          Syn_RowConstraintList 
wrap_RowConstraintList sem (Inh_RowConstraintList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_RowConstraintList _lhsOannotatedTree _lhsOoriginalTree ))
sem_RowConstraintList_Cons :: T_RowConstraint  ->
                              T_RowConstraintList  ->
                              T_RowConstraintList 
sem_RowConstraintList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: RowConstraintList
              _lhsOoriginalTree :: RowConstraintList
              _hdOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _hdIannotatedTree :: RowConstraint
              _hdIoriginalTree :: RowConstraint
              _tlIannotatedTree :: RowConstraintList
              _tlIoriginalTree :: RowConstraintList
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 7806 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 7811 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 7816 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 7821 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 7826 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 7831 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 7836 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 7841 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdIoriginalTree) =
                  (hd_ _hdOcat _hdOlib )
              ( _tlIannotatedTree,_tlIoriginalTree) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_RowConstraintList_Nil :: T_RowConstraintList 
sem_RowConstraintList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: RowConstraintList
              _lhsOoriginalTree :: RowConstraintList
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 7857 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 7862 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 7867 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 7872 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- SelectExpression --------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         libUpdates           : [LocalBindingsUpdate]
         originalTree         : SELF 
   alternatives:
      alternative CombineSelect:
         child ann            : {Annotation}
         child ctype          : CombineType 
         child sel1           : SelectExpression 
         child sel2           : SelectExpression 
         visit 0:
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative Select:
         child ann            : {Annotation}
         child selDistinct    : Distinct 
         child selSelectList  : SelectList 
         child selTref        : TableRefList 
         child selWhere       : MaybeBoolExpression 
         child selGroupBy     : ExpressionList 
         child selHaving      : MaybeBoolExpression 
         child selOrderBy     : ExpressionDirectionPairList 
         child selLimit       : MaybeExpression 
         child selOffset      : MaybeExpression 
         visit 0:
            local newLib      : _
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative Values:
         child ann            : {Annotation}
         child vll            : ExpressionListList 
         visit 0:
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
-}
data SelectExpression  = CombineSelect (Annotation) (CombineType) (SelectExpression) (SelectExpression) 
                       | Select (Annotation) (Distinct) (SelectList) (TableRefList) (MaybeBoolExpression) (ExpressionList) (MaybeBoolExpression) (ExpressionDirectionPairList) (MaybeExpression) (MaybeExpression) 
                       | Values (Annotation) (ExpressionListList) 
                       deriving ( Data,Eq,Show,Typeable)
-- cata
sem_SelectExpression :: SelectExpression  ->
                        T_SelectExpression 
sem_SelectExpression (CombineSelect _ann _ctype _sel1 _sel2 )  =
    (sem_SelectExpression_CombineSelect _ann (sem_CombineType _ctype ) (sem_SelectExpression _sel1 ) (sem_SelectExpression _sel2 ) )
sem_SelectExpression (Select _ann _selDistinct _selSelectList _selTref _selWhere _selGroupBy _selHaving _selOrderBy _selLimit _selOffset )  =
    (sem_SelectExpression_Select _ann (sem_Distinct _selDistinct ) (sem_SelectList _selSelectList ) (sem_TableRefList _selTref ) (sem_MaybeBoolExpression _selWhere ) (sem_ExpressionList _selGroupBy ) (sem_MaybeBoolExpression _selHaving ) (sem_ExpressionDirectionPairList _selOrderBy ) (sem_MaybeExpression _selLimit ) (sem_MaybeExpression _selOffset ) )
sem_SelectExpression (Values _ann _vll )  =
    (sem_SelectExpression_Values _ann (sem_ExpressionListList _vll ) )
-- semantic domain
type T_SelectExpression  = Catalog ->
                           LocalBindings ->
                           ( SelectExpression,([LocalBindingsUpdate]),SelectExpression)
data Inh_SelectExpression  = Inh_SelectExpression {cat_Inh_SelectExpression :: Catalog,lib_Inh_SelectExpression :: LocalBindings}
data Syn_SelectExpression  = Syn_SelectExpression {annotatedTree_Syn_SelectExpression :: SelectExpression,libUpdates_Syn_SelectExpression :: [LocalBindingsUpdate],originalTree_Syn_SelectExpression :: SelectExpression}
wrap_SelectExpression :: T_SelectExpression  ->
                         Inh_SelectExpression  ->
                         Syn_SelectExpression 
wrap_SelectExpression sem (Inh_SelectExpression _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOlibUpdates,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_SelectExpression _lhsOannotatedTree _lhsOlibUpdates _lhsOoriginalTree ))
sem_SelectExpression_CombineSelect :: Annotation ->
                                      T_CombineType  ->
                                      T_SelectExpression  ->
                                      T_SelectExpression  ->
                                      T_SelectExpression 
sem_SelectExpression_CombineSelect ann_ ctype_ sel1_ sel2_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: SelectExpression
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOoriginalTree :: SelectExpression
              _ctypeOcat :: Catalog
              _ctypeOlib :: LocalBindings
              _sel1Ocat :: Catalog
              _sel1Olib :: LocalBindings
              _sel2Ocat :: Catalog
              _sel2Olib :: LocalBindings
              _ctypeIannotatedTree :: CombineType
              _ctypeIoriginalTree :: CombineType
              _sel1IannotatedTree :: SelectExpression
              _sel1IlibUpdates :: ([LocalBindingsUpdate])
              _sel1IoriginalTree :: SelectExpression
              _sel2IannotatedTree :: SelectExpression
              _sel2IlibUpdates :: ([LocalBindingsUpdate])
              _sel2IoriginalTree :: SelectExpression
              -- "./TypeChecking/SelectStatement.ag"(line 23, column 9)
              _lhsOannotatedTree =
                  {-# LINE 23 "./TypeChecking/SelectStatement.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    Nothing
                  {-# LINE 7979 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectStatement.ag"(line 129, column 9)
              _tpe =
                  {-# LINE 129 "./TypeChecking/SelectStatement.ag" #-}
                  let sel1t = getTypeAnnotation _sel1IannotatedTree
                      sel2t = getTypeAnnotation _sel2IannotatedTree
                  in dependsOnRTpe [sel1t, sel2t] $
                        typeCheckCombineSelect _lhsIcat sel1t sel2t
                  {-# LINE 7987 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectStatement.ag"(line 134, column 9)
              _backTree =
                  {-# LINE 134 "./TypeChecking/SelectStatement.ag" #-}
                  CombineSelect ann_ _ctypeIannotatedTree
                                _sel1IannotatedTree
                                _sel2IannotatedTree
                  {-# LINE 7994 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 88, column 11)
              _lhsOlibUpdates =
                  {-# LINE 88 "./TypeChecking/SelectLists.ag" #-}
                  []
                  {-# LINE 7999 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  CombineSelect ann_ _ctypeIannotatedTree _sel1IannotatedTree _sel2IannotatedTree
                  {-# LINE 8004 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  CombineSelect ann_ _ctypeIoriginalTree _sel1IoriginalTree _sel2IoriginalTree
                  {-# LINE 8009 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 8014 "AstInternal.hs" #-}
              -- copy rule (down)
              _ctypeOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8019 "AstInternal.hs" #-}
              -- copy rule (down)
              _ctypeOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 8024 "AstInternal.hs" #-}
              -- copy rule (down)
              _sel1Ocat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8029 "AstInternal.hs" #-}
              -- copy rule (down)
              _sel1Olib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 8034 "AstInternal.hs" #-}
              -- copy rule (down)
              _sel2Ocat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8039 "AstInternal.hs" #-}
              -- copy rule (down)
              _sel2Olib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 8044 "AstInternal.hs" #-}
              ( _ctypeIannotatedTree,_ctypeIoriginalTree) =
                  (ctype_ _ctypeOcat _ctypeOlib )
              ( _sel1IannotatedTree,_sel1IlibUpdates,_sel1IoriginalTree) =
                  (sel1_ _sel1Ocat _sel1Olib )
              ( _sel2IannotatedTree,_sel2IlibUpdates,_sel2IoriginalTree) =
                  (sel2_ _sel2Ocat _sel2Olib )
          in  ( _lhsOannotatedTree,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_SelectExpression_Select :: Annotation ->
                               T_Distinct  ->
                               T_SelectList  ->
                               T_TableRefList  ->
                               T_MaybeBoolExpression  ->
                               T_ExpressionList  ->
                               T_MaybeBoolExpression  ->
                               T_ExpressionDirectionPairList  ->
                               T_MaybeExpression  ->
                               T_MaybeExpression  ->
                               T_SelectExpression 
sem_SelectExpression_Select ann_ selDistinct_ selSelectList_ selTref_ selWhere_ selGroupBy_ selHaving_ selOrderBy_ selLimit_ selOffset_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: SelectExpression
              _selSelectListOlib :: LocalBindings
              _selWhereOlib :: LocalBindings
              _selGroupByOlib :: LocalBindings
              _selOrderByOlib :: LocalBindings
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOoriginalTree :: SelectExpression
              _selDistinctOcat :: Catalog
              _selDistinctOlib :: LocalBindings
              _selSelectListOcat :: Catalog
              _selTrefOcat :: Catalog
              _selTrefOlib :: LocalBindings
              _selWhereOcat :: Catalog
              _selGroupByOcat :: Catalog
              _selHavingOcat :: Catalog
              _selHavingOlib :: LocalBindings
              _selOrderByOcat :: Catalog
              _selLimitOcat :: Catalog
              _selLimitOlib :: LocalBindings
              _selOffsetOcat :: Catalog
              _selOffsetOlib :: LocalBindings
              _selDistinctIannotatedTree :: Distinct
              _selDistinctIoriginalTree :: Distinct
              _selSelectListIannotatedTree :: SelectList
              _selSelectListIlibUpdates :: ([LocalBindingsUpdate])
              _selSelectListIlistType :: ([(String,Type)])
              _selSelectListIoriginalTree :: SelectList
              _selTrefIannotatedTree :: TableRefList
              _selTrefIlibUpdates :: ([LocalBindingsUpdate])
              _selTrefIoriginalTree :: TableRefList
              _selWhereIannotatedTree :: MaybeBoolExpression
              _selWhereIoriginalTree :: MaybeBoolExpression
              _selGroupByIannotatedTree :: ExpressionList
              _selGroupByIoriginalTree :: ExpressionList
              _selGroupByItypeList :: ([Type])
              _selHavingIannotatedTree :: MaybeBoolExpression
              _selHavingIoriginalTree :: MaybeBoolExpression
              _selOrderByIannotatedTree :: ExpressionDirectionPairList
              _selOrderByIoriginalTree :: ExpressionDirectionPairList
              _selLimitIannotatedTree :: MaybeExpression
              _selLimitIoriginalTree :: MaybeExpression
              _selOffsetIannotatedTree :: MaybeExpression
              _selOffsetIoriginalTree :: MaybeExpression
              -- "./TypeChecking/SelectStatement.ag"(line 23, column 9)
              _lhsOannotatedTree =
                  {-# LINE 23 "./TypeChecking/SelectStatement.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    Nothing
                  {-# LINE 8116 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectStatement.ag"(line 94, column 10)
              _newLib =
                  {-# LINE 94 "./TypeChecking/SelectStatement.ag" #-}
                  case foldM (lbUpdate _lhsIcat) _lhsIlib _selTrefIlibUpdates of
                    Left x -> error $ "selectexpression-select-loc.newlib " ++ show x
                    Right e -> e
                  {-# LINE 8123 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectStatement.ag"(line 97, column 10)
              _selSelectListOlib =
                  {-# LINE 97 "./TypeChecking/SelectStatement.ag" #-}
                  _newLib
                  {-# LINE 8128 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectStatement.ag"(line 98, column 10)
              _selWhereOlib =
                  {-# LINE 98 "./TypeChecking/SelectStatement.ag" #-}
                  _newLib
                  {-# LINE 8133 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectStatement.ag"(line 99, column 10)
              _selGroupByOlib =
                  {-# LINE 99 "./TypeChecking/SelectStatement.ag" #-}
                  _newLib
                  {-# LINE 8138 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectStatement.ag"(line 100, column 10)
              _selOrderByOlib =
                  {-# LINE 100 "./TypeChecking/SelectStatement.ag" #-}
                  _newLib
                  {-# LINE 8143 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectStatement.ag"(line 111, column 9)
              _tpe =
                  {-# LINE 111 "./TypeChecking/SelectStatement.ag" #-}
                  do
                  Right $ case _selSelectListIlistType of
                            [(_,Pseudo Void)] -> Pseudo Void
                            _ -> SetOfType $ CompositeType _selSelectListIlistType
                  {-# LINE 8151 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectStatement.ag"(line 118, column 9)
              _backTree =
                  {-# LINE 118 "./TypeChecking/SelectStatement.ag" #-}
                  Select ann_
                         _selDistinctIannotatedTree
                         _selSelectListIannotatedTree
                         _selTrefIannotatedTree
                         _selWhereIannotatedTree
                         _selGroupByIannotatedTree
                         _selHavingIannotatedTree
                         _selOrderByIannotatedTree
                         _selLimitIannotatedTree
                         _selOffsetIannotatedTree
                  {-# LINE 8165 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 86, column 9)
              _lhsOlibUpdates =
                  {-# LINE 86 "./TypeChecking/SelectLists.ag" #-}
                  _selSelectListIlibUpdates
                  {-# LINE 8170 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Select ann_ _selDistinctIannotatedTree _selSelectListIannotatedTree _selTrefIannotatedTree _selWhereIannotatedTree _selGroupByIannotatedTree _selHavingIannotatedTree _selOrderByIannotatedTree _selLimitIannotatedTree _selOffsetIannotatedTree
                  {-# LINE 8175 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Select ann_ _selDistinctIoriginalTree _selSelectListIoriginalTree _selTrefIoriginalTree _selWhereIoriginalTree _selGroupByIoriginalTree _selHavingIoriginalTree _selOrderByIoriginalTree _selLimitIoriginalTree _selOffsetIoriginalTree
                  {-# LINE 8180 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 8185 "AstInternal.hs" #-}
              -- copy rule (down)
              _selDistinctOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8190 "AstInternal.hs" #-}
              -- copy rule (down)
              _selDistinctOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 8195 "AstInternal.hs" #-}
              -- copy rule (down)
              _selSelectListOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8200 "AstInternal.hs" #-}
              -- copy rule (down)
              _selTrefOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8205 "AstInternal.hs" #-}
              -- copy rule (down)
              _selTrefOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 8210 "AstInternal.hs" #-}
              -- copy rule (down)
              _selWhereOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8215 "AstInternal.hs" #-}
              -- copy rule (down)
              _selGroupByOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8220 "AstInternal.hs" #-}
              -- copy rule (down)
              _selHavingOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8225 "AstInternal.hs" #-}
              -- copy rule (down)
              _selHavingOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 8230 "AstInternal.hs" #-}
              -- copy rule (down)
              _selOrderByOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8235 "AstInternal.hs" #-}
              -- copy rule (down)
              _selLimitOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8240 "AstInternal.hs" #-}
              -- copy rule (down)
              _selLimitOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 8245 "AstInternal.hs" #-}
              -- copy rule (down)
              _selOffsetOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8250 "AstInternal.hs" #-}
              -- copy rule (down)
              _selOffsetOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 8255 "AstInternal.hs" #-}
              ( _selDistinctIannotatedTree,_selDistinctIoriginalTree) =
                  (selDistinct_ _selDistinctOcat _selDistinctOlib )
              ( _selSelectListIannotatedTree,_selSelectListIlibUpdates,_selSelectListIlistType,_selSelectListIoriginalTree) =
                  (selSelectList_ _selSelectListOcat _selSelectListOlib )
              ( _selTrefIannotatedTree,_selTrefIlibUpdates,_selTrefIoriginalTree) =
                  (selTref_ _selTrefOcat _selTrefOlib )
              ( _selWhereIannotatedTree,_selWhereIoriginalTree) =
                  (selWhere_ _selWhereOcat _selWhereOlib )
              ( _selGroupByIannotatedTree,_selGroupByIoriginalTree,_selGroupByItypeList) =
                  (selGroupBy_ _selGroupByOcat _selGroupByOlib )
              ( _selHavingIannotatedTree,_selHavingIoriginalTree) =
                  (selHaving_ _selHavingOcat _selHavingOlib )
              ( _selOrderByIannotatedTree,_selOrderByIoriginalTree) =
                  (selOrderBy_ _selOrderByOcat _selOrderByOlib )
              ( _selLimitIannotatedTree,_selLimitIoriginalTree) =
                  (selLimit_ _selLimitOcat _selLimitOlib )
              ( _selOffsetIannotatedTree,_selOffsetIoriginalTree) =
                  (selOffset_ _selOffsetOcat _selOffsetOlib )
          in  ( _lhsOannotatedTree,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_SelectExpression_Values :: Annotation ->
                               T_ExpressionListList  ->
                               T_SelectExpression 
sem_SelectExpression_Values ann_ vll_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: SelectExpression
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOoriginalTree :: SelectExpression
              _vllOcat :: Catalog
              _vllOlib :: LocalBindings
              _vllIannotatedTree :: ExpressionListList
              _vllIoriginalTree :: ExpressionListList
              _vllItypeListList :: ([[Type]])
              -- "./TypeChecking/SelectStatement.ag"(line 23, column 9)
              _lhsOannotatedTree =
                  {-# LINE 23 "./TypeChecking/SelectStatement.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    Nothing
                  {-# LINE 8296 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectStatement.ag"(line 106, column 9)
              _tpe =
                  {-# LINE 106 "./TypeChecking/SelectStatement.ag" #-}
                  typeCheckValuesExpr
                              _lhsIcat
                              _vllItypeListList
                  {-# LINE 8303 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectStatement.ag"(line 109, column 9)
              _backTree =
                  {-# LINE 109 "./TypeChecking/SelectStatement.ag" #-}
                  Values ann_ _vllIannotatedTree
                  {-# LINE 8308 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 88, column 11)
              _lhsOlibUpdates =
                  {-# LINE 88 "./TypeChecking/SelectLists.ag" #-}
                  []
                  {-# LINE 8313 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Values ann_ _vllIannotatedTree
                  {-# LINE 8318 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Values ann_ _vllIoriginalTree
                  {-# LINE 8323 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 8328 "AstInternal.hs" #-}
              -- copy rule (down)
              _vllOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8333 "AstInternal.hs" #-}
              -- copy rule (down)
              _vllOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 8338 "AstInternal.hs" #-}
              ( _vllIannotatedTree,_vllIoriginalTree,_vllItypeListList) =
                  (vll_ _vllOcat _vllOlib )
          in  ( _lhsOannotatedTree,_lhsOlibUpdates,_lhsOoriginalTree)))
-- SelectItem --------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         columnName           : String
         itemType             : Type
         originalTree         : SELF 
   alternatives:
      alternative SelExp:
         child ann            : {Annotation}
         child ex             : Expression 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative SelectItem:
         child ann            : {Annotation}
         child ex             : Expression 
         child name           : {String}
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data SelectItem  = SelExp (Annotation) (Expression) 
                 | SelectItem (Annotation) (Expression) (String) 
                 deriving ( Data,Eq,Show,Typeable)
-- cata
sem_SelectItem :: SelectItem  ->
                  T_SelectItem 
sem_SelectItem (SelExp _ann _ex )  =
    (sem_SelectItem_SelExp _ann (sem_Expression _ex ) )
sem_SelectItem (SelectItem _ann _ex _name )  =
    (sem_SelectItem_SelectItem _ann (sem_Expression _ex ) _name )
-- semantic domain
type T_SelectItem  = Catalog ->
                     LocalBindings ->
                     ( SelectItem,String,Type,SelectItem)
data Inh_SelectItem  = Inh_SelectItem {cat_Inh_SelectItem :: Catalog,lib_Inh_SelectItem :: LocalBindings}
data Syn_SelectItem  = Syn_SelectItem {annotatedTree_Syn_SelectItem :: SelectItem,columnName_Syn_SelectItem :: String,itemType_Syn_SelectItem :: Type,originalTree_Syn_SelectItem :: SelectItem}
wrap_SelectItem :: T_SelectItem  ->
                   Inh_SelectItem  ->
                   Syn_SelectItem 
wrap_SelectItem sem (Inh_SelectItem _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOcolumnName,_lhsOitemType,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_SelectItem _lhsOannotatedTree _lhsOcolumnName _lhsOitemType _lhsOoriginalTree ))
sem_SelectItem_SelExp :: Annotation ->
                         T_Expression  ->
                         T_SelectItem 
sem_SelectItem_SelExp ann_ ex_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOitemType :: Type
              _lhsOcolumnName :: String
              _lhsOannotatedTree :: SelectItem
              _lhsOoriginalTree :: SelectItem
              _exOcat :: Catalog
              _exOlib :: LocalBindings
              _exIannotatedTree :: Expression
              _exIliftedColumnName :: String
              _exIoriginalTree :: Expression
              -- "./TypeChecking/SelectLists.ag"(line 13, column 9)
              _annotatedTree =
                  {-# LINE 13 "./TypeChecking/SelectLists.ag" #-}
                  SelExp ann_ $ fixStar _exIannotatedTree
                  {-# LINE 8410 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 35, column 9)
              _lhsOitemType =
                  {-# LINE 35 "./TypeChecking/SelectLists.ag" #-}
                  getTypeAnnotation _exIannotatedTree
                  {-# LINE 8415 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 182, column 14)
              _lhsOcolumnName =
                  {-# LINE 182 "./TypeChecking/SelectLists.ag" #-}
                  case _exIliftedColumnName of
                    "" -> "?column?"
                    s -> s
                  {-# LINE 8422 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  SelExp ann_ _exIoriginalTree
                  {-# LINE 8427 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 8432 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 8437 "AstInternal.hs" #-}
              -- copy rule (down)
              _exOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8442 "AstInternal.hs" #-}
              -- copy rule (down)
              _exOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 8447 "AstInternal.hs" #-}
              ( _exIannotatedTree,_exIliftedColumnName,_exIoriginalTree) =
                  (ex_ _exOcat _exOlib )
          in  ( _lhsOannotatedTree,_lhsOcolumnName,_lhsOitemType,_lhsOoriginalTree)))
sem_SelectItem_SelectItem :: Annotation ->
                             T_Expression  ->
                             String ->
                             T_SelectItem 
sem_SelectItem_SelectItem ann_ ex_ name_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOitemType :: Type
              _lhsOcolumnName :: String
              _lhsOannotatedTree :: SelectItem
              _lhsOoriginalTree :: SelectItem
              _exOcat :: Catalog
              _exOlib :: LocalBindings
              _exIannotatedTree :: Expression
              _exIliftedColumnName :: String
              _exIoriginalTree :: Expression
              -- "./TypeChecking/SelectLists.ag"(line 15, column 9)
              _annotatedTree =
                  {-# LINE 15 "./TypeChecking/SelectLists.ag" #-}
                  SelectItem ann_ (fixStar _exIannotatedTree) name_
                  {-# LINE 8471 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 35, column 9)
              _lhsOitemType =
                  {-# LINE 35 "./TypeChecking/SelectLists.ag" #-}
                  getTypeAnnotation _exIannotatedTree
                  {-# LINE 8476 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 185, column 18)
              _lhsOcolumnName =
                  {-# LINE 185 "./TypeChecking/SelectLists.ag" #-}
                  name_
                  {-# LINE 8481 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  SelectItem ann_ _exIoriginalTree name_
                  {-# LINE 8486 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 8491 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 8496 "AstInternal.hs" #-}
              -- copy rule (down)
              _exOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8501 "AstInternal.hs" #-}
              -- copy rule (down)
              _exOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 8506 "AstInternal.hs" #-}
              ( _exIannotatedTree,_exIliftedColumnName,_exIoriginalTree) =
                  (ex_ _exOcat _exOlib )
          in  ( _lhsOannotatedTree,_lhsOcolumnName,_lhsOitemType,_lhsOoriginalTree)))
-- SelectItemList ----------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         listType             : [(String,Type)]
         originalTree         : SELF 
   alternatives:
      alternative Cons:
         child hd             : SelectItem 
         child tl             : SelectItemList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type SelectItemList  = [(SelectItem)]
-- cata
sem_SelectItemList :: SelectItemList  ->
                      T_SelectItemList 
sem_SelectItemList list  =
    (Prelude.foldr sem_SelectItemList_Cons sem_SelectItemList_Nil (Prelude.map sem_SelectItem list) )
-- semantic domain
type T_SelectItemList  = Catalog ->
                         LocalBindings ->
                         ( SelectItemList,([(String,Type)]),SelectItemList)
data Inh_SelectItemList  = Inh_SelectItemList {cat_Inh_SelectItemList :: Catalog,lib_Inh_SelectItemList :: LocalBindings}
data Syn_SelectItemList  = Syn_SelectItemList {annotatedTree_Syn_SelectItemList :: SelectItemList,listType_Syn_SelectItemList :: [(String,Type)],originalTree_Syn_SelectItemList :: SelectItemList}
wrap_SelectItemList :: T_SelectItemList  ->
                       Inh_SelectItemList  ->
                       Syn_SelectItemList 
wrap_SelectItemList sem (Inh_SelectItemList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOlistType,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_SelectItemList _lhsOannotatedTree _lhsOlistType _lhsOoriginalTree ))
sem_SelectItemList_Cons :: T_SelectItem  ->
                           T_SelectItemList  ->
                           T_SelectItemList 
sem_SelectItemList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOlistType :: ([(String,Type)])
              _lhsOannotatedTree :: SelectItemList
              _lhsOoriginalTree :: SelectItemList
              _hdOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _hdIannotatedTree :: SelectItem
              _hdIcolumnName :: String
              _hdIitemType :: Type
              _hdIoriginalTree :: SelectItem
              _tlIannotatedTree :: SelectItemList
              _tlIlistType :: ([(String,Type)])
              _tlIoriginalTree :: SelectItemList
              -- "./TypeChecking/SelectLists.ag"(line 29, column 12)
              _lhsOlistType =
                  {-# LINE 29 "./TypeChecking/SelectLists.ag" #-}
                  expandStar _lhsIlib _hdIcolumnName _hdIitemType _tlIlistType
                  {-# LINE 8575 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 8580 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 8585 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 8590 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 8595 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8600 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 8605 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8610 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 8615 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdIcolumnName,_hdIitemType,_hdIoriginalTree) =
                  (hd_ _hdOcat _hdOlib )
              ( _tlIannotatedTree,_tlIlistType,_tlIoriginalTree) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOlistType,_lhsOoriginalTree)))
sem_SelectItemList_Nil :: T_SelectItemList 
sem_SelectItemList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOlistType :: ([(String,Type)])
              _lhsOannotatedTree :: SelectItemList
              _lhsOoriginalTree :: SelectItemList
              -- "./TypeChecking/SelectLists.ag"(line 30, column 11)
              _lhsOlistType =
                  {-# LINE 30 "./TypeChecking/SelectLists.ag" #-}
                  []
                  {-# LINE 8632 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 8637 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 8642 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 8647 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 8652 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOlistType,_lhsOoriginalTree)))
-- SelectList --------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         libUpdates           : [LocalBindingsUpdate]
         listType             : [(String,Type)]
         originalTree         : SELF 
   alternatives:
      alternative SelectList:
         child ann            : {Annotation}
         child items          : SelectItemList 
         child into           : StringList 
         visit 0:
            local errs        : _
            local stuff       : _
            local annotatedTree : _
            local originalTree : _
-}
data SelectList  = SelectList (Annotation) (SelectItemList) (StringList) 
                 deriving ( Data,Eq,Show,Typeable)
-- cata
sem_SelectList :: SelectList  ->
                  T_SelectList 
sem_SelectList (SelectList _ann _items _into )  =
    (sem_SelectList_SelectList _ann (sem_SelectItemList _items ) (sem_StringList _into ) )
-- semantic domain
type T_SelectList  = Catalog ->
                     LocalBindings ->
                     ( SelectList,([LocalBindingsUpdate]),([(String,Type)]),SelectList)
data Inh_SelectList  = Inh_SelectList {cat_Inh_SelectList :: Catalog,lib_Inh_SelectList :: LocalBindings}
data Syn_SelectList  = Syn_SelectList {annotatedTree_Syn_SelectList :: SelectList,libUpdates_Syn_SelectList :: [LocalBindingsUpdate],listType_Syn_SelectList :: [(String,Type)],originalTree_Syn_SelectList :: SelectList}
wrap_SelectList :: T_SelectList  ->
                   Inh_SelectList  ->
                   Syn_SelectList 
wrap_SelectList sem (Inh_SelectList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOlibUpdates,_lhsOlistType,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_SelectList _lhsOannotatedTree _lhsOlibUpdates _lhsOlistType _lhsOoriginalTree ))
sem_SelectList_SelectList :: Annotation ->
                             T_SelectItemList  ->
                             T_StringList  ->
                             T_SelectList 
sem_SelectList_SelectList ann_ items_ into_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOlistType :: ([(String,Type)])
              _lhsOannotatedTree :: SelectList
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOoriginalTree :: SelectList
              _itemsOcat :: Catalog
              _itemsOlib :: LocalBindings
              _intoOcat :: Catalog
              _intoOlib :: LocalBindings
              _itemsIannotatedTree :: SelectItemList
              _itemsIlistType :: ([(String,Type)])
              _itemsIoriginalTree :: SelectItemList
              _intoIannotatedTree :: StringList
              _intoIoriginalTree :: StringList
              _intoIstrings :: ([String])
              -- "./TypeChecking/SelectLists.ag"(line 41, column 9)
              _lhsOlistType =
                  {-# LINE 41 "./TypeChecking/SelectLists.ag" #-}
                  _itemsIlistType
                  {-# LINE 8721 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 43, column 9)
              _errs =
                  {-# LINE 43 "./TypeChecking/SelectLists.ag" #-}
                  case _stuff     of
                    (er,_) -> er
                  {-# LINE 8727 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 45, column 9)
              _stuff =
                  {-# LINE 45 "./TypeChecking/SelectLists.ag" #-}
                  case () of
                    _ | null sl -> ([],Nothing)
                      | not (null targetTypeErrs) -> (targetTypeErrs,Nothing)
                      | (case targetTypes of
                           [PgRecord _] -> True
                           _ -> False) -> ([],Just (head sl, PgRecord $ Just $ CompositeType _itemsIlistType))
                      | matchingComposite /= Left [] -> (fromLeft [] matchingComposite,Nothing)
                      | length sl /= length _itemsIlistType -> ([WrongNumberOfColumns],Nothing)
                      | not (null assignErrs) -> (assignErrs,Nothing)
                      | otherwise -> ([],Nothing)
                  where
                    targetTypeEithers = map (lbLookupID _lhsIlib) sl
                    targetTypeErrs = concat $ lefts $ targetTypeEithers
                    targetTypes = rights $ targetTypeEithers
                    typePairs = zip (map snd _itemsIlistType) targetTypes
                    assignErrs = concat $ lefts $ map (uncurry $ checkAssignmentValid _lhsIcat) typePairs
                    sl = _intoIstrings
                    matchingComposite =
                        case targetTypes of
                          [t] | isCompositeType t -> checkAssignmentValid _lhsIcat (AnonymousRecordType (map snd _itemsIlistType)) t
                          _ -> Left []
                  {-# LINE 8752 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 68, column 9)
              _lhsOannotatedTree =
                  {-# LINE 68 "./TypeChecking/SelectLists.ag" #-}
                  SelectList (ann_ ++ map TypeErrorA _errs    )
                             _itemsIannotatedTree
                             _intoIannotatedTree
                  {-# LINE 8759 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 71, column 9)
              _lhsOlibUpdates =
                  {-# LINE 71 "./TypeChecking/SelectLists.ag" #-}
                  case _stuff     of
                    (_,Just r) -> [LBIds "set record actual fields from select into" ""
                                    [r] []]
                    _ -> []
                  {-# LINE 8767 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  SelectList ann_ _itemsIannotatedTree _intoIannotatedTree
                  {-# LINE 8772 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  SelectList ann_ _itemsIoriginalTree _intoIoriginalTree
                  {-# LINE 8777 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 8782 "AstInternal.hs" #-}
              -- copy rule (down)
              _itemsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8787 "AstInternal.hs" #-}
              -- copy rule (down)
              _itemsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 8792 "AstInternal.hs" #-}
              -- copy rule (down)
              _intoOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8797 "AstInternal.hs" #-}
              -- copy rule (down)
              _intoOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 8802 "AstInternal.hs" #-}
              ( _itemsIannotatedTree,_itemsIlistType,_itemsIoriginalTree) =
                  (items_ _itemsOcat _itemsOlib )
              ( _intoIannotatedTree,_intoIoriginalTree,_intoIstrings) =
                  (into_ _intoOcat _intoOlib )
          in  ( _lhsOannotatedTree,_lhsOlibUpdates,_lhsOlistType,_lhsOoriginalTree)))
-- SetClause ---------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
         pairs                : [(String,Type)]
         rowSetError          : Maybe TypeError
   alternatives:
      alternative RowSetClause:
         child ann            : {Annotation}
         child atts           : StringList 
         child vals           : ExpressionList 
         visit 0:
            local rowSetError : _
            local annotatedTree : _
            local originalTree : _
      alternative SetClause:
         child ann            : {Annotation}
         child att            : {String}
         child val            : Expression 
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data SetClause  = RowSetClause (Annotation) (StringList) (ExpressionList) 
                | SetClause (Annotation) (String) (Expression) 
                deriving ( Data,Eq,Show,Typeable)
-- cata
sem_SetClause :: SetClause  ->
                 T_SetClause 
sem_SetClause (RowSetClause _ann _atts _vals )  =
    (sem_SetClause_RowSetClause _ann (sem_StringList _atts ) (sem_ExpressionList _vals ) )
sem_SetClause (SetClause _ann _att _val )  =
    (sem_SetClause_SetClause _ann _att (sem_Expression _val ) )
-- semantic domain
type T_SetClause  = Catalog ->
                    LocalBindings ->
                    ( SetClause,SetClause,([(String,Type)]),(Maybe TypeError))
data Inh_SetClause  = Inh_SetClause {cat_Inh_SetClause :: Catalog,lib_Inh_SetClause :: LocalBindings}
data Syn_SetClause  = Syn_SetClause {annotatedTree_Syn_SetClause :: SetClause,originalTree_Syn_SetClause :: SetClause,pairs_Syn_SetClause :: [(String,Type)],rowSetError_Syn_SetClause :: Maybe TypeError}
wrap_SetClause :: T_SetClause  ->
                  Inh_SetClause  ->
                  Syn_SetClause 
wrap_SetClause sem (Inh_SetClause _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOpairs,_lhsOrowSetError) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_SetClause _lhsOannotatedTree _lhsOoriginalTree _lhsOpairs _lhsOrowSetError ))
sem_SetClause_RowSetClause :: Annotation ->
                              T_StringList  ->
                              T_ExpressionList  ->
                              T_SetClause 
sem_SetClause_RowSetClause ann_ atts_ vals_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOpairs :: ([(String,Type)])
              _lhsOannotatedTree :: SetClause
              _lhsOoriginalTree :: SetClause
              _lhsOrowSetError :: (Maybe TypeError)
              _attsOcat :: Catalog
              _attsOlib :: LocalBindings
              _valsOcat :: Catalog
              _valsOlib :: LocalBindings
              _attsIannotatedTree :: StringList
              _attsIoriginalTree :: StringList
              _attsIstrings :: ([String])
              _valsIannotatedTree :: ExpressionList
              _valsIoriginalTree :: ExpressionList
              _valsItypeList :: ([Type])
              -- "./TypeChecking/Dml.ag"(line 155, column 9)
              _rowSetError =
                  {-# LINE 155 "./TypeChecking/Dml.ag" #-}
                  let atts = _attsIstrings
                      types = getRowTypes _valsItypeList
                  in if length atts /= length types
                       then Just WrongNumberOfColumns
                       else Nothing
                  {-# LINE 8888 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 161, column 9)
              _lhsOpairs =
                  {-# LINE 161 "./TypeChecking/Dml.ag" #-}
                  zip _attsIstrings $ getRowTypes _valsItypeList
                  {-# LINE 8893 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  RowSetClause ann_ _attsIannotatedTree _valsIannotatedTree
                  {-# LINE 8898 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  RowSetClause ann_ _attsIoriginalTree _valsIoriginalTree
                  {-# LINE 8903 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 8908 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 8913 "AstInternal.hs" #-}
              -- copy rule (from local)
              _lhsOrowSetError =
                  {-# LINE 148 "./TypeChecking/Dml.ag" #-}
                  _rowSetError
                  {-# LINE 8918 "AstInternal.hs" #-}
              -- copy rule (down)
              _attsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8923 "AstInternal.hs" #-}
              -- copy rule (down)
              _attsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 8928 "AstInternal.hs" #-}
              -- copy rule (down)
              _valsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8933 "AstInternal.hs" #-}
              -- copy rule (down)
              _valsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 8938 "AstInternal.hs" #-}
              ( _attsIannotatedTree,_attsIoriginalTree,_attsIstrings) =
                  (atts_ _attsOcat _attsOlib )
              ( _valsIannotatedTree,_valsIoriginalTree,_valsItypeList) =
                  (vals_ _valsOcat _valsOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOpairs,_lhsOrowSetError)))
sem_SetClause_SetClause :: Annotation ->
                           String ->
                           T_Expression  ->
                           T_SetClause 
sem_SetClause_SetClause ann_ att_ val_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOpairs :: ([(String,Type)])
              _lhsOrowSetError :: (Maybe TypeError)
              _lhsOannotatedTree :: SetClause
              _lhsOoriginalTree :: SetClause
              _valOcat :: Catalog
              _valOlib :: LocalBindings
              _valIannotatedTree :: Expression
              _valIliftedColumnName :: String
              _valIoriginalTree :: Expression
              -- "./TypeChecking/Dml.ag"(line 152, column 9)
              _lhsOpairs =
                  {-# LINE 152 "./TypeChecking/Dml.ag" #-}
                  [(att_, getTypeAnnotation _valIannotatedTree)]
                  {-# LINE 8964 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 153, column 9)
              _lhsOrowSetError =
                  {-# LINE 153 "./TypeChecking/Dml.ag" #-}
                  Nothing
                  {-# LINE 8969 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  SetClause ann_ att_ _valIannotatedTree
                  {-# LINE 8974 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  SetClause ann_ att_ _valIoriginalTree
                  {-# LINE 8979 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 8984 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 8989 "AstInternal.hs" #-}
              -- copy rule (down)
              _valOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 8994 "AstInternal.hs" #-}
              -- copy rule (down)
              _valOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 8999 "AstInternal.hs" #-}
              ( _valIannotatedTree,_valIliftedColumnName,_valIoriginalTree) =
                  (val_ _valOcat _valOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOpairs,_lhsOrowSetError)))
-- SetClauseList -----------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
         pairs                : [(String,Type)]
         rowSetErrors         : [TypeError]
   alternatives:
      alternative Cons:
         child hd             : SetClause 
         child tl             : SetClauseList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type SetClauseList  = [(SetClause)]
-- cata
sem_SetClauseList :: SetClauseList  ->
                     T_SetClauseList 
sem_SetClauseList list  =
    (Prelude.foldr sem_SetClauseList_Cons sem_SetClauseList_Nil (Prelude.map sem_SetClause list) )
-- semantic domain
type T_SetClauseList  = Catalog ->
                        LocalBindings ->
                        ( SetClauseList,SetClauseList,([(String,Type)]),([TypeError]))
data Inh_SetClauseList  = Inh_SetClauseList {cat_Inh_SetClauseList :: Catalog,lib_Inh_SetClauseList :: LocalBindings}
data Syn_SetClauseList  = Syn_SetClauseList {annotatedTree_Syn_SetClauseList :: SetClauseList,originalTree_Syn_SetClauseList :: SetClauseList,pairs_Syn_SetClauseList :: [(String,Type)],rowSetErrors_Syn_SetClauseList :: [TypeError]}
wrap_SetClauseList :: T_SetClauseList  ->
                      Inh_SetClauseList  ->
                      Syn_SetClauseList 
wrap_SetClauseList sem (Inh_SetClauseList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOpairs,_lhsOrowSetErrors) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_SetClauseList _lhsOannotatedTree _lhsOoriginalTree _lhsOpairs _lhsOrowSetErrors ))
sem_SetClauseList_Cons :: T_SetClause  ->
                          T_SetClauseList  ->
                          T_SetClauseList 
sem_SetClauseList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOpairs :: ([(String,Type)])
              _lhsOrowSetErrors :: ([TypeError])
              _lhsOannotatedTree :: SetClauseList
              _lhsOoriginalTree :: SetClauseList
              _hdOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _hdIannotatedTree :: SetClause
              _hdIoriginalTree :: SetClause
              _hdIpairs :: ([(String,Type)])
              _hdIrowSetError :: (Maybe TypeError)
              _tlIannotatedTree :: SetClauseList
              _tlIoriginalTree :: SetClauseList
              _tlIpairs :: ([(String,Type)])
              _tlIrowSetErrors :: ([TypeError])
              -- "./TypeChecking/Dml.ag"(line 142, column 10)
              _lhsOpairs =
                  {-# LINE 142 "./TypeChecking/Dml.ag" #-}
                  _hdIpairs ++ _tlIpairs
                  {-# LINE 9071 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 143, column 10)
              _lhsOrowSetErrors =
                  {-# LINE 143 "./TypeChecking/Dml.ag" #-}
                  maybeToList _hdIrowSetError ++ _tlIrowSetErrors
                  {-# LINE 9076 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 9081 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 9086 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 9091 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 9096 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 9101 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 9106 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 9111 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 9116 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdIoriginalTree,_hdIpairs,_hdIrowSetError) =
                  (hd_ _hdOcat _hdOlib )
              ( _tlIannotatedTree,_tlIoriginalTree,_tlIpairs,_tlIrowSetErrors) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOpairs,_lhsOrowSetErrors)))
sem_SetClauseList_Nil :: T_SetClauseList 
sem_SetClauseList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOpairs :: ([(String,Type)])
              _lhsOrowSetErrors :: ([TypeError])
              _lhsOannotatedTree :: SetClauseList
              _lhsOoriginalTree :: SetClauseList
              -- "./TypeChecking/Dml.ag"(line 144, column 9)
              _lhsOpairs =
                  {-# LINE 144 "./TypeChecking/Dml.ag" #-}
                  []
                  {-# LINE 9134 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 145, column 9)
              _lhsOrowSetErrors =
                  {-# LINE 145 "./TypeChecking/Dml.ag" #-}
                  []
                  {-# LINE 9139 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 9144 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 9149 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 9154 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 9159 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOpairs,_lhsOrowSetErrors)))
-- SetValue ----------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative SetId:
         child ann            : {Annotation}
         child string         : {String}
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative SetNum:
         child ann            : {Annotation}
         child double         : {Double}
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative SetStr:
         child ann            : {Annotation}
         child string         : {String}
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data SetValue  = SetId (Annotation) (String) 
               | SetNum (Annotation) (Double) 
               | SetStr (Annotation) (String) 
               deriving ( Data,Eq,Show,Typeable)
-- cata
sem_SetValue :: SetValue  ->
                T_SetValue 
sem_SetValue (SetId _ann _string )  =
    (sem_SetValue_SetId _ann _string )
sem_SetValue (SetNum _ann _double )  =
    (sem_SetValue_SetNum _ann _double )
sem_SetValue (SetStr _ann _string )  =
    (sem_SetValue_SetStr _ann _string )
-- semantic domain
type T_SetValue  = Catalog ->
                   LocalBindings ->
                   ( SetValue,SetValue)
data Inh_SetValue  = Inh_SetValue {cat_Inh_SetValue :: Catalog,lib_Inh_SetValue :: LocalBindings}
data Syn_SetValue  = Syn_SetValue {annotatedTree_Syn_SetValue :: SetValue,originalTree_Syn_SetValue :: SetValue}
wrap_SetValue :: T_SetValue  ->
                 Inh_SetValue  ->
                 Syn_SetValue 
wrap_SetValue sem (Inh_SetValue _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_SetValue _lhsOannotatedTree _lhsOoriginalTree ))
sem_SetValue_SetId :: Annotation ->
                      String ->
                      T_SetValue 
sem_SetValue_SetId ann_ string_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: SetValue
              _lhsOoriginalTree :: SetValue
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  SetId ann_ string_
                  {-# LINE 9228 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  SetId ann_ string_
                  {-# LINE 9233 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 9238 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 9243 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_SetValue_SetNum :: Annotation ->
                       Double ->
                       T_SetValue 
sem_SetValue_SetNum ann_ double_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: SetValue
              _lhsOoriginalTree :: SetValue
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  SetNum ann_ double_
                  {-# LINE 9257 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  SetNum ann_ double_
                  {-# LINE 9262 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 9267 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 9272 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_SetValue_SetStr :: Annotation ->
                       String ->
                       T_SetValue 
sem_SetValue_SetStr ann_ string_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: SetValue
              _lhsOoriginalTree :: SetValue
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  SetStr ann_ string_
                  {-# LINE 9286 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  SetStr ann_ string_
                  {-# LINE 9291 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 9296 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 9301 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- Statement ---------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         inProducedCat        : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         catUpdates           : [CatalogUpdate]
         libUpdates           : [LocalBindingsUpdate]
         originalTree         : SELF 
   alternatives:
      alternative AlterSequence:
         child ann            : {Annotation}
         child name           : {String}
         child ownedBy        : {String}
         visit 0:
            local libUpdates  : _
            local annotatedTree : _
            local originalTree : _
      alternative AlterTable:
         child ann            : {Annotation}
         child name           : {String}
         child actions        : {[AlterTableAction]}
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Assignment:
         child ann            : {Annotation}
         child target         : {String}
         child value          : Expression 
         visit 0:
            local libUpdates  : _
            local tpe         : {Either [TypeError] Type}
            local backTree    : _
            local catUpdates  : {[CatalogUpdate]}
            local statementType : _
            local annotatedTree : _
            local originalTree : _
      alternative CaseStatement:
         child ann            : {Annotation}
         child val            : Expression 
         child cases          : ExpressionListStatementListPairList 
         child els            : StatementList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative ContinueStatement:
         child ann            : {Annotation}
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Copy:
         child ann            : {Annotation}
         child table          : {String}
         child targetCols     : StringList 
         child source         : CopySource 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative CopyData:
         child ann            : {Annotation}
         child insData        : {String}
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative CreateDomain:
         child ann            : {Annotation}
         child name           : {String}
         child typ            : TypeName 
         child checkName      : {String}
         child check          : MaybeBoolExpression 
         visit 0:
            local libUpdates  : _
            local tpe         : {Either [TypeError] Type}
            local backTree    : _
            local statementType : _
            local catUpdates  : {[CatalogUpdate]}
            local annotatedTree : _
            local originalTree : _
      alternative CreateFunction:
         child ann            : {Annotation}
         child name           : {String}
         child params         : ParamDefList 
         child rettype        : TypeName 
         child lang           : Language 
         child bodyQuote      : {String}
         child body           : FnBody 
         child vol            : Volatility 
         visit 0:
            local libUpdates  : _
            local tpe         : {Either [TypeError] Type}
            local catUpdates  : {[CatalogUpdate]}
            local parameterTypes : _
            local backTree    : _
            local statementType : _
            local annotatedTree : _
            local originalTree : _
      alternative CreateLanguage:
         child ann            : {Annotation}
         child name           : {String}
         visit 0:
            local libUpdates  : _
            local tpe         : {Either [TypeError] Type}
            local backTree    : _
            local statementType : _
            local catUpdates  : {[CatalogUpdate]}
            local annotatedTree : _
            local originalTree : _
      alternative CreateSequence:
         child ann            : {Annotation}
         child name           : {String}
         child incr           : {Integer}
         child min            : {Integer}
         child max            : {Integer}
         child start          : {Integer}
         child cache          : {Integer}
         visit 0:
            local libUpdates  : _
            local annotatedTree : _
            local originalTree : _
      alternative CreateTable:
         child ann            : {Annotation}
         child name           : {String}
         child atts           : AttributeDefList 
         child cons           : ConstraintList 
         visit 0:
            local libUpdates  : _
            local tpe         : {Either [TypeError] Type}
            local catUpdates  : {[CatalogUpdate]}
            local attrTypes   : {[Type]}
            local statementType : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative CreateTableAs:
         child ann            : {Annotation}
         child name           : {String}
         child expr           : SelectExpression 
         visit 0:
            local libUpdates  : _
            local tpe         : {Either [TypeError] Type}
            local catUpdates  : {[CatalogUpdate]}
            local selType     : _
            local attrs       : _
            local backTree    : _
            local statementType : _
            local annotatedTree : _
            local originalTree : _
      alternative CreateTrigger:
         child ann            : {Annotation}
         child name           : {String}
         child wh             : TriggerWhen 
         child events         : {[TriggerEvent]}
         child tbl            : {String}
         child firing         : TriggerFire 
         child fnName         : {String}
         child fnArgs         : {[Expression]}
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative CreateType:
         child ann            : {Annotation}
         child name           : {String}
         child atts           : TypeAttributeDefList 
         visit 0:
            local libUpdates  : _
            local tpe         : {Either [TypeError] Type}
            local backTree    : _
            local statementType : _
            local catUpdates  : {[CatalogUpdate]}
            local annotatedTree : _
            local originalTree : _
      alternative CreateView:
         child ann            : {Annotation}
         child name           : {String}
         child expr           : SelectExpression 
         visit 0:
            local libUpdates  : _
            local tpe         : {Either [TypeError] Type}
            local backTree    : _
            local attrs       : _
            local catUpdates  : {[CatalogUpdate]}
            local statementType : _
            local annotatedTree : _
            local originalTree : _
      alternative Delete:
         child ann            : {Annotation}
         child table          : {String}
         child whr            : MaybeBoolExpression 
         child returning      : MaybeSelectList 
         visit 0:
            local libUpdates  : _
            local tpe         : {Either [TypeError] Type}
            local statementType : _
            local backTree    : _
            local catUpdates  : {[CatalogUpdate]}
            local lib         : _
            local annotatedTree : _
            local originalTree : _
      alternative DropFunction:
         child ann            : {Annotation}
         child ifE            : IfExists 
         child sigs           : StringTypeNameListPairList 
         child cascade        : Cascade 
         visit 0:
            local libUpdates  : _
            local tpe         : {Either [TypeError] Type}
            local backTree    : _
            local catUpdates  : {[CatalogUpdate]}
            local statementType : _
            local annotatedTree : _
            local originalTree : _
      alternative DropSomething:
         child ann            : {Annotation}
         child dropType       : DropType 
         child ifE            : IfExists 
         child names          : StringList 
         child cascade        : Cascade 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Execute:
         child ann            : {Annotation}
         child expr           : Expression 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative ExecuteInto:
         child ann            : {Annotation}
         child expr           : Expression 
         child targets        : StringList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative ForIntegerStatement:
         child ann            : {Annotation}
         child var            : {String}
         child from           : Expression 
         child to             : Expression 
         child sts            : StatementList 
         visit 0:
            local libUpdates  : _
            local varTypeE    : _
            local tpe         : {Either [TypeError] Type}
            local backTree    : _
            local catUpdates  : {[CatalogUpdate]}
            local statementType : _
            local annotatedTree : _
            local originalTree : _
      alternative ForSelectStatement:
         child ann            : {Annotation}
         child var            : {String}
         child sel            : SelectExpression 
         child sts            : StatementList 
         visit 0:
            local libUpdates  : _
            local selType     : _
            local tpe         : {Either [TypeError] Type}
            local backTree    : _
            local catUpdates  : {[CatalogUpdate]}
            local statementType : _
            local annotatedTree : _
            local originalTree : _
      alternative If:
         child ann            : {Annotation}
         child cases          : ExpressionStatementListPairList 
         child els            : StatementList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Insert:
         child ann            : {Annotation}
         child table          : {String}
         child targetCols     : StringList 
         child insData        : SelectExpression 
         child returning      : MaybeSelectList 
         visit 0:
            local libUpdates  : _
            local tpe         : {Either [TypeError] Type}
            local statementType : _
            local columnTypes : _
            local insDataAddedInferredTypes : _
            local backTree    : _
            local catUpdates  : {[CatalogUpdate]}
            local annotatedTree : _
            local originalTree : _
      alternative Notify:
         child ann            : {Annotation}
         child name           : {String}
         visit 0:
            local libUpdates  : _
            local annotatedTree : _
            local originalTree : _
      alternative NullStatement:
         child ann            : {Annotation}
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Perform:
         child ann            : {Annotation}
         child expr           : Expression 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Raise:
         child ann            : {Annotation}
         child level          : RaiseType 
         child message        : {String}
         child args           : ExpressionList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Return:
         child ann            : {Annotation}
         child value          : MaybeExpression 
         visit 0:
            local libUpdates  : _
            local tpe         : {Either [TypeError] Type}
            local backTree    : _
            local catUpdates  : {[CatalogUpdate]}
            local statementType : _
            local annotatedTree : _
            local originalTree : _
      alternative ReturnNext:
         child ann            : {Annotation}
         child expr           : Expression 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative ReturnQuery:
         child ann            : {Annotation}
         child sel            : SelectExpression 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative SelectStatement:
         child ann            : {Annotation}
         child ex             : SelectExpression 
         visit 0:
            local tpe         : {Either [TypeError] Type}
            local statementType : _
            local backTree    : _
            local catUpdates  : {[CatalogUpdate]}
            local libUpdates  : _
            local annotatedTree : _
            local originalTree : _
      alternative Set:
         child ann            : {Annotation}
         child name           : {String}
         child values         : {[SetValue]}
         visit 0:
            local libUpdates  : _
            local annotatedTree : _
            local originalTree : _
      alternative Truncate:
         child ann            : {Annotation}
         child tables         : StringList 
         child restartIdentity : RestartIdentity 
         child cascade        : Cascade 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Update:
         child ann            : {Annotation}
         child table          : {String}
         child assigns        : SetClauseList 
         child whr            : MaybeBoolExpression 
         child returning      : MaybeSelectList 
         visit 0:
            local libUpdates  : _
            local tpe         : {Either [TypeError] Type}
            local statementType : _
            local columnTypes : _
            local assignWInferredTypes : {SetClauseList}
            local backTree    : _
            local catUpdates  : {[CatalogUpdate]}
            local lib         : _
            local annotatedTree : _
            local originalTree : _
      alternative WhileStatement:
         child ann            : {Annotation}
         child expr           : Expression 
         child sts            : StatementList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data Statement  = AlterSequence (Annotation) (String) (String) 
                | AlterTable (Annotation) (String) ([AlterTableAction]) 
                | Assignment (Annotation) (String) (Expression) 
                | CaseStatement (Annotation) (Expression) (ExpressionListStatementListPairList) (StatementList) 
                | ContinueStatement (Annotation) 
                | Copy (Annotation) (String) (StringList) (CopySource) 
                | CopyData (Annotation) (String) 
                | CreateDomain (Annotation) (String) (TypeName) (String) (MaybeBoolExpression) 
                | CreateFunction (Annotation) (String) (ParamDefList) (TypeName) (Language) (String) (FnBody) (Volatility) 
                | CreateLanguage (Annotation) (String) 
                | CreateSequence (Annotation) (String) (Integer) (Integer) (Integer) (Integer) (Integer) 
                | CreateTable (Annotation) (String) (AttributeDefList) (ConstraintList) 
                | CreateTableAs (Annotation) (String) (SelectExpression) 
                | CreateTrigger (Annotation) (String) (TriggerWhen) ([TriggerEvent]) (String) (TriggerFire) (String) ([Expression]) 
                | CreateType (Annotation) (String) (TypeAttributeDefList) 
                | CreateView (Annotation) (String) (SelectExpression) 
                | Delete (Annotation) (String) (MaybeBoolExpression) (MaybeSelectList) 
                | DropFunction (Annotation) (IfExists) (StringTypeNameListPairList) (Cascade) 
                | DropSomething (Annotation) (DropType) (IfExists) (StringList) (Cascade) 
                | Execute (Annotation) (Expression) 
                | ExecuteInto (Annotation) (Expression) (StringList) 
                | ForIntegerStatement (Annotation) (String) (Expression) (Expression) (StatementList) 
                | ForSelectStatement (Annotation) (String) (SelectExpression) (StatementList) 
                | If (Annotation) (ExpressionStatementListPairList) (StatementList) 
                | Insert (Annotation) (String) (StringList) (SelectExpression) (MaybeSelectList) 
                | Notify (Annotation) (String) 
                | NullStatement (Annotation) 
                | Perform (Annotation) (Expression) 
                | Raise (Annotation) (RaiseType) (String) (ExpressionList) 
                | Return (Annotation) (MaybeExpression) 
                | ReturnNext (Annotation) (Expression) 
                | ReturnQuery (Annotation) (SelectExpression) 
                | SelectStatement (Annotation) (SelectExpression) 
                | Set (Annotation) (String) ([SetValue]) 
                | Truncate (Annotation) (StringList) (RestartIdentity) (Cascade) 
                | Update (Annotation) (String) (SetClauseList) (MaybeBoolExpression) (MaybeSelectList) 
                | WhileStatement (Annotation) (Expression) (StatementList) 
                deriving ( Data,Eq,Show,Typeable)
-- cata
sem_Statement :: Statement  ->
                 T_Statement 
sem_Statement (AlterSequence _ann _name _ownedBy )  =
    (sem_Statement_AlterSequence _ann _name _ownedBy )
sem_Statement (AlterTable _ann _name _actions )  =
    (sem_Statement_AlterTable _ann _name _actions )
sem_Statement (Assignment _ann _target _value )  =
    (sem_Statement_Assignment _ann _target (sem_Expression _value ) )
sem_Statement (CaseStatement _ann _val _cases _els )  =
    (sem_Statement_CaseStatement _ann (sem_Expression _val ) (sem_ExpressionListStatementListPairList _cases ) (sem_StatementList _els ) )
sem_Statement (ContinueStatement _ann )  =
    (sem_Statement_ContinueStatement _ann )
sem_Statement (Copy _ann _table _targetCols _source )  =
    (sem_Statement_Copy _ann _table (sem_StringList _targetCols ) (sem_CopySource _source ) )
sem_Statement (CopyData _ann _insData )  =
    (sem_Statement_CopyData _ann _insData )
sem_Statement (CreateDomain _ann _name _typ _checkName _check )  =
    (sem_Statement_CreateDomain _ann _name (sem_TypeName _typ ) _checkName (sem_MaybeBoolExpression _check ) )
sem_Statement (CreateFunction _ann _name _params _rettype _lang _bodyQuote _body _vol )  =
    (sem_Statement_CreateFunction _ann _name (sem_ParamDefList _params ) (sem_TypeName _rettype ) (sem_Language _lang ) _bodyQuote (sem_FnBody _body ) (sem_Volatility _vol ) )
sem_Statement (CreateLanguage _ann _name )  =
    (sem_Statement_CreateLanguage _ann _name )
sem_Statement (CreateSequence _ann _name _incr _min _max _start _cache )  =
    (sem_Statement_CreateSequence _ann _name _incr _min _max _start _cache )
sem_Statement (CreateTable _ann _name _atts _cons )  =
    (sem_Statement_CreateTable _ann _name (sem_AttributeDefList _atts ) (sem_ConstraintList _cons ) )
sem_Statement (CreateTableAs _ann _name _expr )  =
    (sem_Statement_CreateTableAs _ann _name (sem_SelectExpression _expr ) )
sem_Statement (CreateTrigger _ann _name _wh _events _tbl _firing _fnName _fnArgs )  =
    (sem_Statement_CreateTrigger _ann _name (sem_TriggerWhen _wh ) _events _tbl (sem_TriggerFire _firing ) _fnName _fnArgs )
sem_Statement (CreateType _ann _name _atts )  =
    (sem_Statement_CreateType _ann _name (sem_TypeAttributeDefList _atts ) )
sem_Statement (CreateView _ann _name _expr )  =
    (sem_Statement_CreateView _ann _name (sem_SelectExpression _expr ) )
sem_Statement (Delete _ann _table _whr _returning )  =
    (sem_Statement_Delete _ann _table (sem_MaybeBoolExpression _whr ) (sem_MaybeSelectList _returning ) )
sem_Statement (DropFunction _ann _ifE _sigs _cascade )  =
    (sem_Statement_DropFunction _ann (sem_IfExists _ifE ) (sem_StringTypeNameListPairList _sigs ) (sem_Cascade _cascade ) )
sem_Statement (DropSomething _ann _dropType _ifE _names _cascade )  =
    (sem_Statement_DropSomething _ann (sem_DropType _dropType ) (sem_IfExists _ifE ) (sem_StringList _names ) (sem_Cascade _cascade ) )
sem_Statement (Execute _ann _expr )  =
    (sem_Statement_Execute _ann (sem_Expression _expr ) )
sem_Statement (ExecuteInto _ann _expr _targets )  =
    (sem_Statement_ExecuteInto _ann (sem_Expression _expr ) (sem_StringList _targets ) )
sem_Statement (ForIntegerStatement _ann _var _from _to _sts )  =
    (sem_Statement_ForIntegerStatement _ann _var (sem_Expression _from ) (sem_Expression _to ) (sem_StatementList _sts ) )
sem_Statement (ForSelectStatement _ann _var _sel _sts )  =
    (sem_Statement_ForSelectStatement _ann _var (sem_SelectExpression _sel ) (sem_StatementList _sts ) )
sem_Statement (If _ann _cases _els )  =
    (sem_Statement_If _ann (sem_ExpressionStatementListPairList _cases ) (sem_StatementList _els ) )
sem_Statement (Insert _ann _table _targetCols _insData _returning )  =
    (sem_Statement_Insert _ann _table (sem_StringList _targetCols ) (sem_SelectExpression _insData ) (sem_MaybeSelectList _returning ) )
sem_Statement (Notify _ann _name )  =
    (sem_Statement_Notify _ann _name )
sem_Statement (NullStatement _ann )  =
    (sem_Statement_NullStatement _ann )
sem_Statement (Perform _ann _expr )  =
    (sem_Statement_Perform _ann (sem_Expression _expr ) )
sem_Statement (Raise _ann _level _message _args )  =
    (sem_Statement_Raise _ann (sem_RaiseType _level ) _message (sem_ExpressionList _args ) )
sem_Statement (Return _ann _value )  =
    (sem_Statement_Return _ann (sem_MaybeExpression _value ) )
sem_Statement (ReturnNext _ann _expr )  =
    (sem_Statement_ReturnNext _ann (sem_Expression _expr ) )
sem_Statement (ReturnQuery _ann _sel )  =
    (sem_Statement_ReturnQuery _ann (sem_SelectExpression _sel ) )
sem_Statement (SelectStatement _ann _ex )  =
    (sem_Statement_SelectStatement _ann (sem_SelectExpression _ex ) )
sem_Statement (Set _ann _name _values )  =
    (sem_Statement_Set _ann _name _values )
sem_Statement (Truncate _ann _tables _restartIdentity _cascade )  =
    (sem_Statement_Truncate _ann (sem_StringList _tables ) (sem_RestartIdentity _restartIdentity ) (sem_Cascade _cascade ) )
sem_Statement (Update _ann _table _assigns _whr _returning )  =
    (sem_Statement_Update _ann _table (sem_SetClauseList _assigns ) (sem_MaybeBoolExpression _whr ) (sem_MaybeSelectList _returning ) )
sem_Statement (WhileStatement _ann _expr _sts )  =
    (sem_Statement_WhileStatement _ann (sem_Expression _expr ) (sem_StatementList _sts ) )
-- semantic domain
type T_Statement  = Catalog ->
                    Catalog ->
                    LocalBindings ->
                    ( Statement,([CatalogUpdate]),([LocalBindingsUpdate]),Statement)
data Inh_Statement  = Inh_Statement {cat_Inh_Statement :: Catalog,inProducedCat_Inh_Statement :: Catalog,lib_Inh_Statement :: LocalBindings}
data Syn_Statement  = Syn_Statement {annotatedTree_Syn_Statement :: Statement,catUpdates_Syn_Statement :: [CatalogUpdate],libUpdates_Syn_Statement :: [LocalBindingsUpdate],originalTree_Syn_Statement :: Statement}
wrap_Statement :: T_Statement  ->
                  Inh_Statement  ->
                  Syn_Statement 
wrap_Statement sem (Inh_Statement _lhsIcat _lhsIinProducedCat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIinProducedCat _lhsIlib )
     in  (Syn_Statement _lhsOannotatedTree _lhsOcatUpdates _lhsOlibUpdates _lhsOoriginalTree ))
sem_Statement_AlterSequence :: Annotation ->
                               String ->
                               String ->
                               T_Statement 
sem_Statement_AlterSequence ann_ name_ ownedBy_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 9837 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 9842 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 9847 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  AlterSequence ann_ name_ ownedBy_
                  {-# LINE 9852 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  AlterSequence ann_ name_ ownedBy_
                  {-# LINE 9857 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 9862 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 9867 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_AlterTable :: Annotation ->
                            String ->
                            ([AlterTableAction]) ->
                            T_Statement 
sem_Statement_AlterTable ann_ name_ actions_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 9885 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 9890 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  AlterTable ann_ name_ actions_
                  {-# LINE 9895 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  AlterTable ann_ name_ actions_
                  {-# LINE 9900 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 9905 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 9910 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_Assignment :: Annotation ->
                            String ->
                            T_Expression  ->
                            T_Statement 
sem_Statement_Assignment ann_ target_ value_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Statement
              _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _tpe :: (Either [TypeError] Type)
              _catUpdates :: ([CatalogUpdate])
              _lhsOoriginalTree :: Statement
              _valueOcat :: Catalog
              _valueOlib :: LocalBindings
              _valueIannotatedTree :: Expression
              _valueIliftedColumnName :: String
              _valueIoriginalTree :: Expression
              -- "./TypeChecking/Statements.ag"(line 61, column 9)
              _lhsOannotatedTree =
                  {-# LINE 61 "./TypeChecking/Statements.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ Just (map StatementTypeA _statementType     ++
                            [CatUpdates _catUpdates    ])
                  {-# LINE 9939 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 67, column 9)
              _lhsOcatUpdates =
                  {-# LINE 67 "./TypeChecking/Statements.ag" #-}
                  _catUpdates
                  {-# LINE 9944 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 68, column 9)
              _lhsOlibUpdates =
                  {-# LINE 68 "./TypeChecking/Statements.ag" #-}
                  _libUpdates
                  {-# LINE 9949 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 9954 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 23, column 9)
              _tpe =
                  {-# LINE 23 "./TypeChecking/Plpgsql.ag" #-}
                  do
                  let fromType = getTypeAnnotation _valueIannotatedTree
                  toType <- lbLookupID _lhsIlib target_
                  dependsOnRTpe [getTypeAnnotation _valueIannotatedTree, toType] $ do
                  checkAssignmentValid _lhsIcat fromType toType
                  return $ Pseudo Void
                  {-# LINE 9964 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 30, column 9)
              _backTree =
                  {-# LINE 30 "./TypeChecking/Plpgsql.ag" #-}
                  Assignment ann_ target_ _valueIannotatedTree
                  {-# LINE 9969 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 31, column 9)
              _catUpdates =
                  {-# LINE 31 "./TypeChecking/Plpgsql.ag" #-}
                  []
                  {-# LINE 9974 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 32, column 9)
              _statementType =
                  {-# LINE 32 "./TypeChecking/Plpgsql.ag" #-}
                  []
                  {-# LINE 9979 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Assignment ann_ target_ _valueIannotatedTree
                  {-# LINE 9984 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Assignment ann_ target_ _valueIoriginalTree
                  {-# LINE 9989 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 9994 "AstInternal.hs" #-}
              -- copy rule (down)
              _valueOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 9999 "AstInternal.hs" #-}
              -- copy rule (down)
              _valueOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 10004 "AstInternal.hs" #-}
              ( _valueIannotatedTree,_valueIliftedColumnName,_valueIoriginalTree) =
                  (value_ _valueOcat _valueOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_CaseStatement :: Annotation ->
                               T_Expression  ->
                               T_ExpressionListStatementListPairList  ->
                               T_StatementList  ->
                               T_Statement 
sem_Statement_CaseStatement ann_ val_ cases_ els_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _elsOcatUpdates :: ([CatalogUpdate])
              _elsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              _valOcat :: Catalog
              _valOlib :: LocalBindings
              _casesOcat :: Catalog
              _casesOlib :: LocalBindings
              _elsOcat :: Catalog
              _elsOlib :: LocalBindings
              _valIannotatedTree :: Expression
              _valIliftedColumnName :: String
              _valIoriginalTree :: Expression
              _casesIannotatedTree :: ExpressionListStatementListPairList
              _casesIoriginalTree :: ExpressionListStatementListPairList
              _elsIannotatedTree :: StatementList
              _elsIoriginalTree :: StatementList
              _elsIproducedCat :: Catalog
              _elsIproducedLib :: LocalBindings
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10042 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10047 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 106, column 9)
              _elsOcatUpdates =
                  {-# LINE 106 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10052 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 107, column 9)
              _elsOlibUpdates =
                  {-# LINE 107 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10057 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  CaseStatement ann_ _valIannotatedTree _casesIannotatedTree _elsIannotatedTree
                  {-# LINE 10062 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  CaseStatement ann_ _valIoriginalTree _casesIoriginalTree _elsIoriginalTree
                  {-# LINE 10067 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 10072 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 10077 "AstInternal.hs" #-}
              -- copy rule (down)
              _valOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 10082 "AstInternal.hs" #-}
              -- copy rule (down)
              _valOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 10087 "AstInternal.hs" #-}
              -- copy rule (down)
              _casesOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 10092 "AstInternal.hs" #-}
              -- copy rule (down)
              _casesOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 10097 "AstInternal.hs" #-}
              -- copy rule (down)
              _elsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 10102 "AstInternal.hs" #-}
              -- copy rule (down)
              _elsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 10107 "AstInternal.hs" #-}
              ( _valIannotatedTree,_valIliftedColumnName,_valIoriginalTree) =
                  (val_ _valOcat _valOlib )
              ( _casesIannotatedTree,_casesIoriginalTree) =
                  (cases_ _casesOcat _casesOlib )
              ( _elsIannotatedTree,_elsIoriginalTree,_elsIproducedCat,_elsIproducedLib) =
                  (els_ _elsOcat _elsOcatUpdates _elsOlib _elsOlibUpdates )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_ContinueStatement :: Annotation ->
                                   T_Statement 
sem_Statement_ContinueStatement ann_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10129 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10134 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  ContinueStatement ann_
                  {-# LINE 10139 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  ContinueStatement ann_
                  {-# LINE 10144 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 10149 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 10154 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_Copy :: Annotation ->
                      String ->
                      T_StringList  ->
                      T_CopySource  ->
                      T_Statement 
sem_Statement_Copy ann_ table_ targetCols_ source_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              _targetColsOcat :: Catalog
              _targetColsOlib :: LocalBindings
              _sourceOcat :: Catalog
              _sourceOlib :: LocalBindings
              _targetColsIannotatedTree :: StringList
              _targetColsIoriginalTree :: StringList
              _targetColsIstrings :: ([String])
              _sourceIannotatedTree :: CopySource
              _sourceIoriginalTree :: CopySource
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10182 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10187 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Copy ann_ table_ _targetColsIannotatedTree _sourceIannotatedTree
                  {-# LINE 10192 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Copy ann_ table_ _targetColsIoriginalTree _sourceIoriginalTree
                  {-# LINE 10197 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 10202 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 10207 "AstInternal.hs" #-}
              -- copy rule (down)
              _targetColsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 10212 "AstInternal.hs" #-}
              -- copy rule (down)
              _targetColsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 10217 "AstInternal.hs" #-}
              -- copy rule (down)
              _sourceOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 10222 "AstInternal.hs" #-}
              -- copy rule (down)
              _sourceOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 10227 "AstInternal.hs" #-}
              ( _targetColsIannotatedTree,_targetColsIoriginalTree,_targetColsIstrings) =
                  (targetCols_ _targetColsOcat _targetColsOlib )
              ( _sourceIannotatedTree,_sourceIoriginalTree) =
                  (source_ _sourceOcat _sourceOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_CopyData :: Annotation ->
                          String ->
                          T_Statement 
sem_Statement_CopyData ann_ insData_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10248 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10253 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  CopyData ann_ insData_
                  {-# LINE 10258 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  CopyData ann_ insData_
                  {-# LINE 10263 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 10268 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 10273 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_CreateDomain :: Annotation ->
                              String ->
                              T_TypeName  ->
                              String ->
                              T_MaybeBoolExpression  ->
                              T_Statement 
sem_Statement_CreateDomain ann_ name_ typ_ checkName_ check_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Statement
              _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _tpe :: (Either [TypeError] Type)
              _catUpdates :: ([CatalogUpdate])
              _checkOlib :: LocalBindings
              _lhsOoriginalTree :: Statement
              _typOcat :: Catalog
              _typOlib :: LocalBindings
              _checkOcat :: Catalog
              _typIannotatedTree :: TypeName
              _typInamedType :: Type
              _typIoriginalTree :: TypeName
              _checkIannotatedTree :: MaybeBoolExpression
              _checkIoriginalTree :: MaybeBoolExpression
              -- "./TypeChecking/Statements.ag"(line 61, column 9)
              _lhsOannotatedTree =
                  {-# LINE 61 "./TypeChecking/Statements.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ Just (map StatementTypeA _statementType     ++
                            [CatUpdates _catUpdates    ])
                  {-# LINE 10308 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 67, column 9)
              _lhsOcatUpdates =
                  {-# LINE 67 "./TypeChecking/Statements.ag" #-}
                  _catUpdates
                  {-# LINE 10313 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 68, column 9)
              _lhsOlibUpdates =
                  {-# LINE 68 "./TypeChecking/Statements.ag" #-}
                  _libUpdates
                  {-# LINE 10318 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10323 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 64, column 9)
              _tpe =
                  {-# LINE 64 "./TypeChecking/MiscCreates.ag" #-}
                  Right $ Pseudo Void
                  {-# LINE 10328 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 65, column 9)
              _backTree =
                  {-# LINE 65 "./TypeChecking/MiscCreates.ag" #-}
                  CreateDomain ann_ name_ _typIannotatedTree checkName_ _checkIannotatedTree
                  {-# LINE 10333 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 66, column 9)
              _statementType =
                  {-# LINE 66 "./TypeChecking/MiscCreates.ag" #-}
                  []
                  {-# LINE 10338 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 67, column 9)
              _catUpdates =
                  {-# LINE 67 "./TypeChecking/MiscCreates.ag" #-}
                  [CatCreateDomain (DomainType name_) _typInamedType]
                  {-# LINE 10343 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 69, column 9)
              _checkOlib =
                  {-# LINE 69 "./TypeChecking/MiscCreates.ag" #-}
                  fromRight _lhsIlib $
                  lbUpdate _lhsIcat _lhsIlib $
                  LBIds "domain check value" "" [("value", _typInamedType)] []
                  {-# LINE 10350 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  CreateDomain ann_ name_ _typIannotatedTree checkName_ _checkIannotatedTree
                  {-# LINE 10355 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  CreateDomain ann_ name_ _typIoriginalTree checkName_ _checkIoriginalTree
                  {-# LINE 10360 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 10365 "AstInternal.hs" #-}
              -- copy rule (down)
              _typOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 10370 "AstInternal.hs" #-}
              -- copy rule (down)
              _typOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 10375 "AstInternal.hs" #-}
              -- copy rule (down)
              _checkOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 10380 "AstInternal.hs" #-}
              ( _typIannotatedTree,_typInamedType,_typIoriginalTree) =
                  (typ_ _typOcat _typOlib )
              ( _checkIannotatedTree,_checkIoriginalTree) =
                  (check_ _checkOcat _checkOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_CreateFunction :: Annotation ->
                                String ->
                                T_ParamDefList  ->
                                T_TypeName  ->
                                T_Language  ->
                                String ->
                                T_FnBody  ->
                                T_Volatility  ->
                                T_Statement 
sem_Statement_CreateFunction ann_ name_ params_ rettype_ lang_ bodyQuote_ body_ vol_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Statement
              _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _tpe :: (Either [TypeError] Type)
              _catUpdates :: ([CatalogUpdate])
              _bodyOcat :: Catalog
              _bodyOlib :: LocalBindings
              _lhsOoriginalTree :: Statement
              _paramsOcat :: Catalog
              _paramsOlib :: LocalBindings
              _rettypeOcat :: Catalog
              _rettypeOlib :: LocalBindings
              _langOcat :: Catalog
              _langOlib :: LocalBindings
              _volOcat :: Catalog
              _volOlib :: LocalBindings
              _paramsIannotatedTree :: ParamDefList
              _paramsIoriginalTree :: ParamDefList
              _paramsIparams :: ([(String, Type)])
              _rettypeIannotatedTree :: TypeName
              _rettypeInamedType :: Type
              _rettypeIoriginalTree :: TypeName
              _langIannotatedTree :: Language
              _langIoriginalTree :: Language
              _bodyIannotatedTree :: FnBody
              _bodyIoriginalTree :: FnBody
              _volIannotatedTree :: Volatility
              _volIoriginalTree :: Volatility
              -- "./TypeChecking/Statements.ag"(line 61, column 9)
              _lhsOannotatedTree =
                  {-# LINE 61 "./TypeChecking/Statements.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ Just (map StatementTypeA _statementType     ++
                            [CatUpdates _catUpdates    ])
                  {-# LINE 10435 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 67, column 9)
              _lhsOcatUpdates =
                  {-# LINE 67 "./TypeChecking/Statements.ag" #-}
                  _catUpdates
                  {-# LINE 10440 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 68, column 9)
              _lhsOlibUpdates =
                  {-# LINE 68 "./TypeChecking/Statements.ag" #-}
                  _libUpdates
                  {-# LINE 10445 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10450 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateFunction.ag"(line 23, column 9)
              _tpe =
                  {-# LINE 23 "./TypeChecking/CreateFunction.ag" #-}
                  dependsOnRTpe
                    (_rettypeInamedType : _parameterTypes    ) $
                    Right $ Pseudo Void
                  {-# LINE 10457 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateFunction.ag"(line 26, column 9)
              _catUpdates =
                  {-# LINE 26 "./TypeChecking/CreateFunction.ag" #-}
                  dependsOn [tpeToT _tpe    ] []
                            [CatCreateFunction FunName
                                               (map toLower name_)
                                               _parameterTypes
                                               _rettypeInamedType
                                               False]
                  {-# LINE 10467 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateFunction.ag"(line 32, column 9)
              _parameterTypes =
                  {-# LINE 32 "./TypeChecking/CreateFunction.ag" #-}
                  (map snd _paramsIparams)
                  {-# LINE 10472 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateFunction.ag"(line 34, column 9)
              _backTree =
                  {-# LINE 34 "./TypeChecking/CreateFunction.ag" #-}
                  CreateFunction ann_
                                 name_
                                 _paramsIannotatedTree
                                 _rettypeIannotatedTree
                                 _langIannotatedTree
                                 bodyQuote_
                                 _bodyIannotatedTree
                                 _volIannotatedTree
                  {-# LINE 10484 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateFunction.ag"(line 42, column 9)
              _statementType =
                  {-# LINE 42 "./TypeChecking/CreateFunction.ag" #-}
                  []
                  {-# LINE 10489 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateFunction.ag"(line 43, column 9)
              _bodyOcat =
                  {-# LINE 43 "./TypeChecking/CreateFunction.ag" #-}
                  _lhsIinProducedCat
                  {-# LINE 10494 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateFunction.ag"(line 99, column 9)
              _bodyOlib =
                  {-# LINE 99 "./TypeChecking/CreateFunction.ag" #-}
                  let p = _paramsIparams
                          ++ (zip posNames $ map snd _paramsIparams)
                  in fromRight _lhsIlib $ do
                     a <- lbUpdate _lhsIcat _lhsIlib (LBIds (name_ ++ " parameters") "" p [])
                     lbUpdate _lhsIcat a (LBIds (name_ ++ " parameters") name_ _paramsIparams [])
                  where
                    posNames :: [String]
                    posNames = map (\l -> '$':show l) [1..]
                  {-# LINE 10506 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  CreateFunction ann_ name_ _paramsIannotatedTree _rettypeIannotatedTree _langIannotatedTree bodyQuote_ _bodyIannotatedTree _volIannotatedTree
                  {-# LINE 10511 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  CreateFunction ann_ name_ _paramsIoriginalTree _rettypeIoriginalTree _langIoriginalTree bodyQuote_ _bodyIoriginalTree _volIoriginalTree
                  {-# LINE 10516 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 10521 "AstInternal.hs" #-}
              -- copy rule (down)
              _paramsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 10526 "AstInternal.hs" #-}
              -- copy rule (down)
              _paramsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 10531 "AstInternal.hs" #-}
              -- copy rule (down)
              _rettypeOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 10536 "AstInternal.hs" #-}
              -- copy rule (down)
              _rettypeOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 10541 "AstInternal.hs" #-}
              -- copy rule (down)
              _langOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 10546 "AstInternal.hs" #-}
              -- copy rule (down)
              _langOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 10551 "AstInternal.hs" #-}
              -- copy rule (down)
              _volOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 10556 "AstInternal.hs" #-}
              -- copy rule (down)
              _volOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 10561 "AstInternal.hs" #-}
              ( _paramsIannotatedTree,_paramsIoriginalTree,_paramsIparams) =
                  (params_ _paramsOcat _paramsOlib )
              ( _rettypeIannotatedTree,_rettypeInamedType,_rettypeIoriginalTree) =
                  (rettype_ _rettypeOcat _rettypeOlib )
              ( _langIannotatedTree,_langIoriginalTree) =
                  (lang_ _langOcat _langOlib )
              ( _bodyIannotatedTree,_bodyIoriginalTree) =
                  (body_ _bodyOcat _bodyOlib )
              ( _volIannotatedTree,_volIoriginalTree) =
                  (vol_ _volOcat _volOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_CreateLanguage :: Annotation ->
                                String ->
                                T_Statement 
sem_Statement_CreateLanguage ann_ name_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Statement
              _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _tpe :: (Either [TypeError] Type)
              _catUpdates :: ([CatalogUpdate])
              _lhsOoriginalTree :: Statement
              -- "./TypeChecking/Statements.ag"(line 61, column 9)
              _lhsOannotatedTree =
                  {-# LINE 61 "./TypeChecking/Statements.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ Just (map StatementTypeA _statementType     ++
                            [CatUpdates _catUpdates    ])
                  {-# LINE 10594 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 67, column 9)
              _lhsOcatUpdates =
                  {-# LINE 67 "./TypeChecking/Statements.ag" #-}
                  _catUpdates
                  {-# LINE 10599 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 68, column 9)
              _lhsOlibUpdates =
                  {-# LINE 68 "./TypeChecking/Statements.ag" #-}
                  _libUpdates
                  {-# LINE 10604 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10609 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 75, column 9)
              _tpe =
                  {-# LINE 75 "./TypeChecking/MiscCreates.ag" #-}
                  Right $ Pseudo Void
                  {-# LINE 10614 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 76, column 9)
              _backTree =
                  {-# LINE 76 "./TypeChecking/MiscCreates.ag" #-}
                  CreateLanguage ann_ name_
                  {-# LINE 10619 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 77, column 9)
              _statementType =
                  {-# LINE 77 "./TypeChecking/MiscCreates.ag" #-}
                  []
                  {-# LINE 10624 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 78, column 9)
              _catUpdates =
                  {-# LINE 78 "./TypeChecking/MiscCreates.ag" #-}
                  [CatCreateFunction FunName "plpgsql_call_handler" [] (Pseudo LanguageHandler) False
                  ,CatCreateFunction FunName "plpgsql_validator" [ScalarType "oid"] (Pseudo Void) False]
                  {-# LINE 10630 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  CreateLanguage ann_ name_
                  {-# LINE 10635 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  CreateLanguage ann_ name_
                  {-# LINE 10640 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 10645 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_CreateSequence :: Annotation ->
                                String ->
                                Integer ->
                                Integer ->
                                Integer ->
                                Integer ->
                                Integer ->
                                T_Statement 
sem_Statement_CreateSequence ann_ name_ incr_ min_ max_ start_ cache_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10667 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10672 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10677 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  CreateSequence ann_ name_ incr_ min_ max_ start_ cache_
                  {-# LINE 10682 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  CreateSequence ann_ name_ incr_ min_ max_ start_ cache_
                  {-# LINE 10687 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 10692 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 10697 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_CreateTable :: Annotation ->
                             String ->
                             T_AttributeDefList  ->
                             T_ConstraintList  ->
                             T_Statement 
sem_Statement_CreateTable ann_ name_ atts_ cons_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Statement
              _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _tpe :: (Either [TypeError] Type)
              _catUpdates :: ([CatalogUpdate])
              _attrTypes :: ([Type])
              _consOlib :: LocalBindings
              _lhsOoriginalTree :: Statement
              _attsOcat :: Catalog
              _attsOlib :: LocalBindings
              _consOcat :: Catalog
              _attsIannotatedTree :: AttributeDefList
              _attsIattrs :: ([(String, Type)])
              _attsIoriginalTree :: AttributeDefList
              _consIannotatedTree :: ConstraintList
              _consIoriginalTree :: ConstraintList
              -- "./TypeChecking/Statements.ag"(line 61, column 9)
              _lhsOannotatedTree =
                  {-# LINE 61 "./TypeChecking/Statements.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ Just (map StatementTypeA _statementType     ++
                            [CatUpdates _catUpdates    ])
                  {-# LINE 10732 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 67, column 9)
              _lhsOcatUpdates =
                  {-# LINE 67 "./TypeChecking/Statements.ag" #-}
                  _catUpdates
                  {-# LINE 10737 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 68, column 9)
              _lhsOlibUpdates =
                  {-# LINE 68 "./TypeChecking/Statements.ag" #-}
                  _libUpdates
                  {-# LINE 10742 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10747 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateTable.ag"(line 25, column 9)
              _tpe =
                  {-# LINE 25 "./TypeChecking/CreateTable.ag" #-}
                  dependsOnRTpe _attrTypes     $ Right $ Pseudo Void
                  {-# LINE 10752 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateTable.ag"(line 26, column 9)
              _catUpdates =
                  {-# LINE 26 "./TypeChecking/CreateTable.ag" #-}
                  dependsOn _attrTypes     []
                    [CatCreateTable name_ _attsIattrs defaultSystemColumns]
                  {-# LINE 10758 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateTable.ag"(line 29, column 9)
              _attrTypes =
                  {-# LINE 29 "./TypeChecking/CreateTable.ag" #-}
                  map snd _attsIattrs
                  {-# LINE 10763 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateTable.ag"(line 31, column 9)
              _statementType =
                  {-# LINE 31 "./TypeChecking/CreateTable.ag" #-}
                  []
                  {-# LINE 10768 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateTable.ag"(line 32, column 9)
              _backTree =
                  {-# LINE 32 "./TypeChecking/CreateTable.ag" #-}
                  CreateTable ann_
                              name_
                              _attsIannotatedTree
                              _consIannotatedTree
                  {-# LINE 10776 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateTable.ag"(line 36, column 9)
              _consOlib =
                  {-# LINE 36 "./TypeChecking/CreateTable.ag" #-}
                  case lbUpdate _lhsIcat _lhsIlib $
                         LBIds "attributedefs" "" _attsIattrs [] of
                     Left x -> error $ "statement-createtable-cons.lib " ++ show x
                     Right e -> e
                  {-# LINE 10784 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  CreateTable ann_ name_ _attsIannotatedTree _consIannotatedTree
                  {-# LINE 10789 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  CreateTable ann_ name_ _attsIoriginalTree _consIoriginalTree
                  {-# LINE 10794 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 10799 "AstInternal.hs" #-}
              -- copy rule (down)
              _attsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 10804 "AstInternal.hs" #-}
              -- copy rule (down)
              _attsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 10809 "AstInternal.hs" #-}
              -- copy rule (down)
              _consOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 10814 "AstInternal.hs" #-}
              ( _attsIannotatedTree,_attsIattrs,_attsIoriginalTree) =
                  (atts_ _attsOcat _attsOlib )
              ( _consIannotatedTree,_consIoriginalTree) =
                  (cons_ _consOcat _consOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_CreateTableAs :: Annotation ->
                               String ->
                               T_SelectExpression  ->
                               T_Statement 
sem_Statement_CreateTableAs ann_ name_ expr_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Statement
              _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _tpe :: (Either [TypeError] Type)
              _catUpdates :: ([CatalogUpdate])
              _lhsOoriginalTree :: Statement
              _exprOcat :: Catalog
              _exprOlib :: LocalBindings
              _exprIannotatedTree :: SelectExpression
              _exprIlibUpdates :: ([LocalBindingsUpdate])
              _exprIoriginalTree :: SelectExpression
              -- "./TypeChecking/Statements.ag"(line 61, column 9)
              _lhsOannotatedTree =
                  {-# LINE 61 "./TypeChecking/Statements.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ Just (map StatementTypeA _statementType     ++
                            [CatUpdates _catUpdates    ])
                  {-# LINE 10847 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 67, column 9)
              _lhsOcatUpdates =
                  {-# LINE 67 "./TypeChecking/Statements.ag" #-}
                  _catUpdates
                  {-# LINE 10852 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 68, column 9)
              _lhsOlibUpdates =
                  {-# LINE 68 "./TypeChecking/Statements.ag" #-}
                  _libUpdates
                  {-# LINE 10857 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10862 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateTable.ag"(line 53, column 9)
              _tpe =
                  {-# LINE 53 "./TypeChecking/CreateTable.ag" #-}
                  dependsOnRTpe [_selType    ] $ do
                    _attrs
                    Right _selType
                  {-# LINE 10869 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateTable.ag"(line 57, column 9)
              _catUpdates =
                  {-# LINE 57 "./TypeChecking/CreateTable.ag" #-}
                  leftToEmpty (\as -> [CatCreateTable name_ as defaultSystemColumns]) $ do
                     ats <- _attrs
                     return $ dependsOn (tpeToT _tpe     :
                                         (map snd ats)) [] ats
                  {-# LINE 10877 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateTable.ag"(line 63, column 9)
              _selType =
                  {-# LINE 63 "./TypeChecking/CreateTable.ag" #-}
                  getTypeAnnotation _exprIannotatedTree
                  {-# LINE 10882 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateTable.ag"(line 65, column 9)
              _attrs =
                  {-# LINE 65 "./TypeChecking/CreateTable.ag" #-}
                  unwrapSetOfComposite _selType
                  {-# LINE 10887 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateTable.ag"(line 67, column 9)
              _backTree =
                  {-# LINE 67 "./TypeChecking/CreateTable.ag" #-}
                  CreateTableAs ann_ name_ _exprIannotatedTree
                  {-# LINE 10892 "AstInternal.hs" #-}
              -- "./TypeChecking/CreateTable.ag"(line 68, column 9)
              _statementType =
                  {-# LINE 68 "./TypeChecking/CreateTable.ag" #-}
                  []
                  {-# LINE 10897 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  CreateTableAs ann_ name_ _exprIannotatedTree
                  {-# LINE 10902 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  CreateTableAs ann_ name_ _exprIoriginalTree
                  {-# LINE 10907 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 10912 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 10917 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 10922 "AstInternal.hs" #-}
              ( _exprIannotatedTree,_exprIlibUpdates,_exprIoriginalTree) =
                  (expr_ _exprOcat _exprOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_CreateTrigger :: Annotation ->
                               String ->
                               T_TriggerWhen  ->
                               ([TriggerEvent]) ->
                               String ->
                               T_TriggerFire  ->
                               String ->
                               ([Expression]) ->
                               T_Statement 
sem_Statement_CreateTrigger ann_ name_ wh_ events_ tbl_ firing_ fnName_ fnArgs_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              _whOcat :: Catalog
              _whOlib :: LocalBindings
              _firingOcat :: Catalog
              _firingOlib :: LocalBindings
              _whIannotatedTree :: TriggerWhen
              _whIoriginalTree :: TriggerWhen
              _firingIannotatedTree :: TriggerFire
              _firingIoriginalTree :: TriggerFire
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10955 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 10960 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  CreateTrigger ann_ name_ _whIannotatedTree events_ tbl_ _firingIannotatedTree fnName_ fnArgs_
                  {-# LINE 10965 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  CreateTrigger ann_ name_ _whIoriginalTree events_ tbl_ _firingIoriginalTree fnName_ fnArgs_
                  {-# LINE 10970 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 10975 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 10980 "AstInternal.hs" #-}
              -- copy rule (down)
              _whOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 10985 "AstInternal.hs" #-}
              -- copy rule (down)
              _whOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 10990 "AstInternal.hs" #-}
              -- copy rule (down)
              _firingOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 10995 "AstInternal.hs" #-}
              -- copy rule (down)
              _firingOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 11000 "AstInternal.hs" #-}
              ( _whIannotatedTree,_whIoriginalTree) =
                  (wh_ _whOcat _whOlib )
              ( _firingIannotatedTree,_firingIoriginalTree) =
                  (firing_ _firingOcat _firingOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_CreateType :: Annotation ->
                            String ->
                            T_TypeAttributeDefList  ->
                            T_Statement 
sem_Statement_CreateType ann_ name_ atts_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Statement
              _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _tpe :: (Either [TypeError] Type)
              _catUpdates :: ([CatalogUpdate])
              _lhsOoriginalTree :: Statement
              _attsOcat :: Catalog
              _attsOlib :: LocalBindings
              _attsIannotatedTree :: TypeAttributeDefList
              _attsIattrs :: ([(String, Type)])
              _attsIoriginalTree :: TypeAttributeDefList
              -- "./TypeChecking/Statements.ag"(line 61, column 9)
              _lhsOannotatedTree =
                  {-# LINE 61 "./TypeChecking/Statements.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ Just (map StatementTypeA _statementType     ++
                            [CatUpdates _catUpdates    ])
                  {-# LINE 11033 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 67, column 9)
              _lhsOcatUpdates =
                  {-# LINE 67 "./TypeChecking/Statements.ag" #-}
                  _catUpdates
                  {-# LINE 11038 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 68, column 9)
              _lhsOlibUpdates =
                  {-# LINE 68 "./TypeChecking/Statements.ag" #-}
                  _libUpdates
                  {-# LINE 11043 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 11048 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 51, column 9)
              _tpe =
                  {-# LINE 51 "./TypeChecking/MiscCreates.ag" #-}
                  Right $ Pseudo Void
                  {-# LINE 11053 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 52, column 9)
              _backTree =
                  {-# LINE 52 "./TypeChecking/MiscCreates.ag" #-}
                  CreateType ann_ name_ _attsIannotatedTree
                  {-# LINE 11058 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 53, column 9)
              _statementType =
                  {-# LINE 53 "./TypeChecking/MiscCreates.ag" #-}
                  []
                  {-# LINE 11063 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 54, column 9)
              _catUpdates =
                  {-# LINE 54 "./TypeChecking/MiscCreates.ag" #-}
                  [CatCreateComposite name_ _attsIattrs]
                  {-# LINE 11068 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  CreateType ann_ name_ _attsIannotatedTree
                  {-# LINE 11073 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  CreateType ann_ name_ _attsIoriginalTree
                  {-# LINE 11078 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 11083 "AstInternal.hs" #-}
              -- copy rule (down)
              _attsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11088 "AstInternal.hs" #-}
              -- copy rule (down)
              _attsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 11093 "AstInternal.hs" #-}
              ( _attsIannotatedTree,_attsIattrs,_attsIoriginalTree) =
                  (atts_ _attsOcat _attsOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_CreateView :: Annotation ->
                            String ->
                            T_SelectExpression  ->
                            T_Statement 
sem_Statement_CreateView ann_ name_ expr_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Statement
              _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _tpe :: (Either [TypeError] Type)
              _catUpdates :: ([CatalogUpdate])
              _lhsOoriginalTree :: Statement
              _exprOcat :: Catalog
              _exprOlib :: LocalBindings
              _exprIannotatedTree :: SelectExpression
              _exprIlibUpdates :: ([LocalBindingsUpdate])
              _exprIoriginalTree :: SelectExpression
              -- "./TypeChecking/Statements.ag"(line 61, column 9)
              _lhsOannotatedTree =
                  {-# LINE 61 "./TypeChecking/Statements.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ Just (map StatementTypeA _statementType     ++
                            [CatUpdates _catUpdates    ])
                  {-# LINE 11124 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 67, column 9)
              _lhsOcatUpdates =
                  {-# LINE 67 "./TypeChecking/Statements.ag" #-}
                  _catUpdates
                  {-# LINE 11129 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 68, column 9)
              _lhsOlibUpdates =
                  {-# LINE 68 "./TypeChecking/Statements.ag" #-}
                  _libUpdates
                  {-# LINE 11134 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 11139 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 15, column 9)
              _tpe =
                  {-# LINE 15 "./TypeChecking/MiscCreates.ag" #-}
                  dependsOnRTpe [getTypeAnnotation _exprIannotatedTree] $
                    Right $ Pseudo Void
                  {-# LINE 11145 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 17, column 9)
              _backTree =
                  {-# LINE 17 "./TypeChecking/MiscCreates.ag" #-}
                  CreateView ann_ name_ _exprIannotatedTree
                  {-# LINE 11150 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 18, column 9)
              _attrs =
                  {-# LINE 18 "./TypeChecking/MiscCreates.ag" #-}
                  case getTypeAnnotation _exprIannotatedTree of
                    SetOfType (CompositeType c) -> c
                    _ -> []
                  {-# LINE 11157 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 21, column 9)
              _catUpdates =
                  {-# LINE 21 "./TypeChecking/MiscCreates.ag" #-}
                  [CatCreateView name_ _attrs    ]
                  {-# LINE 11162 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 22, column 9)
              _statementType =
                  {-# LINE 22 "./TypeChecking/MiscCreates.ag" #-}
                  []
                  {-# LINE 11167 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  CreateView ann_ name_ _exprIannotatedTree
                  {-# LINE 11172 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  CreateView ann_ name_ _exprIoriginalTree
                  {-# LINE 11177 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 11182 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11187 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 11192 "AstInternal.hs" #-}
              ( _exprIannotatedTree,_exprIlibUpdates,_exprIoriginalTree) =
                  (expr_ _exprOcat _exprOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_Delete :: Annotation ->
                        String ->
                        T_MaybeBoolExpression  ->
                        T_MaybeSelectList  ->
                        T_Statement 
sem_Statement_Delete ann_ table_ whr_ returning_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Statement
              _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _tpe :: (Either [TypeError] Type)
              _catUpdates :: ([CatalogUpdate])
              _whrOlib :: LocalBindings
              _returningOlib :: LocalBindings
              _lhsOoriginalTree :: Statement
              _whrOcat :: Catalog
              _returningOcat :: Catalog
              _whrIannotatedTree :: MaybeBoolExpression
              _whrIoriginalTree :: MaybeBoolExpression
              _returningIannotatedTree :: MaybeSelectList
              _returningIlistType :: (Maybe [(String,Type)])
              _returningIoriginalTree :: MaybeSelectList
              -- "./TypeChecking/Statements.ag"(line 61, column 9)
              _lhsOannotatedTree =
                  {-# LINE 61 "./TypeChecking/Statements.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ Just (map StatementTypeA _statementType     ++
                            [CatUpdates _catUpdates    ])
                  {-# LINE 11228 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 67, column 9)
              _lhsOcatUpdates =
                  {-# LINE 67 "./TypeChecking/Statements.ag" #-}
                  _catUpdates
                  {-# LINE 11233 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 68, column 9)
              _lhsOlibUpdates =
                  {-# LINE 68 "./TypeChecking/Statements.ag" #-}
                  _libUpdates
                  {-# LINE 11238 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 11243 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 180, column 9)
              _tpe =
                  {-# LINE 180 "./TypeChecking/Dml.ag" #-}
                  checkRelationExists _lhsIcat table_ >>
                  Right (Pseudo Void)
                  {-# LINE 11249 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 183, column 9)
              _statementType =
                  {-# LINE 183 "./TypeChecking/Dml.ag" #-}
                  [StatementType (getPlaceholderTypes _whrIannotatedTree)
                                 (fromMaybe [] _returningIlistType)]
                  {-# LINE 11255 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 186, column 9)
              _backTree =
                  {-# LINE 186 "./TypeChecking/Dml.ag" #-}
                  Delete ann_ table_ _whrIannotatedTree _returningIannotatedTree
                  {-# LINE 11260 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 187, column 9)
              _catUpdates =
                  {-# LINE 187 "./TypeChecking/Dml.ag" #-}
                  []
                  {-# LINE 11265 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 192, column 9)
              _lib =
                  {-# LINE 192 "./TypeChecking/Dml.ag" #-}
                  fromRight _lhsIlib $ do
                  columnTypes <- catCompositeAttrs _lhsIcat relationComposites table_
                  lbUpdate _lhsIcat _lhsIlib $ LBIds "delete table attrs" "" columnTypes []
                  {-# LINE 11272 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 196, column 9)
              _whrOlib =
                  {-# LINE 196 "./TypeChecking/Dml.ag" #-}
                  _lib
                  {-# LINE 11277 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 197, column 9)
              _returningOlib =
                  {-# LINE 197 "./TypeChecking/Dml.ag" #-}
                  _lib
                  {-# LINE 11282 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Delete ann_ table_ _whrIannotatedTree _returningIannotatedTree
                  {-# LINE 11287 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Delete ann_ table_ _whrIoriginalTree _returningIoriginalTree
                  {-# LINE 11292 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 11297 "AstInternal.hs" #-}
              -- copy rule (down)
              _whrOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11302 "AstInternal.hs" #-}
              -- copy rule (down)
              _returningOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11307 "AstInternal.hs" #-}
              ( _whrIannotatedTree,_whrIoriginalTree) =
                  (whr_ _whrOcat _whrOlib )
              ( _returningIannotatedTree,_returningIlistType,_returningIoriginalTree) =
                  (returning_ _returningOcat _returningOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_DropFunction :: Annotation ->
                              T_IfExists  ->
                              T_StringTypeNameListPairList  ->
                              T_Cascade  ->
                              T_Statement 
sem_Statement_DropFunction ann_ ifE_ sigs_ cascade_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Statement
              _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _tpe :: (Either [TypeError] Type)
              _catUpdates :: ([CatalogUpdate])
              _lhsOoriginalTree :: Statement
              _ifEOcat :: Catalog
              _ifEOlib :: LocalBindings
              _sigsOcat :: Catalog
              _sigsOlib :: LocalBindings
              _cascadeOcat :: Catalog
              _cascadeOlib :: LocalBindings
              _ifEIannotatedTree :: IfExists
              _ifEIoriginalTree :: IfExists
              _sigsIannotatedTree :: StringTypeNameListPairList
              _sigsIfnSigs :: ([(String,[Type])])
              _sigsIoriginalTree :: StringTypeNameListPairList
              _cascadeIannotatedTree :: Cascade
              _cascadeIoriginalTree :: Cascade
              -- "./TypeChecking/Statements.ag"(line 61, column 9)
              _lhsOannotatedTree =
                  {-# LINE 61 "./TypeChecking/Statements.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ Just (map StatementTypeA _statementType     ++
                            [CatUpdates _catUpdates    ])
                  {-# LINE 11349 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 67, column 9)
              _lhsOcatUpdates =
                  {-# LINE 67 "./TypeChecking/Statements.ag" #-}
                  _catUpdates
                  {-# LINE 11354 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 68, column 9)
              _lhsOlibUpdates =
                  {-# LINE 68 "./TypeChecking/Statements.ag" #-}
                  _libUpdates
                  {-# LINE 11359 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 11364 "AstInternal.hs" #-}
              -- "./TypeChecking/Drops.ag"(line 10, column 9)
              _tpe =
                  {-# LINE 10 "./TypeChecking/Drops.ag" #-}
                  Right $ Pseudo Void
                  {-# LINE 11369 "AstInternal.hs" #-}
              -- "./TypeChecking/Drops.ag"(line 11, column 9)
              _backTree =
                  {-# LINE 11 "./TypeChecking/Drops.ag" #-}
                  DropFunction ann_ _ifEIannotatedTree _sigsIannotatedTree _cascadeIannotatedTree
                  {-# LINE 11374 "AstInternal.hs" #-}
              -- "./TypeChecking/Drops.ag"(line 12, column 9)
              _catUpdates =
                  {-# LINE 12 "./TypeChecking/Drops.ag" #-}
                  flip map _sigsIfnSigs $ \(nm,args) ->
                        CatDropFunction ifE nm args
                  where
                    ifE = _ifEIannotatedTree == IfExists
                  {-# LINE 11382 "AstInternal.hs" #-}
              -- "./TypeChecking/Drops.ag"(line 16, column 9)
              _statementType =
                  {-# LINE 16 "./TypeChecking/Drops.ag" #-}
                  []
                  {-# LINE 11387 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  DropFunction ann_ _ifEIannotatedTree _sigsIannotatedTree _cascadeIannotatedTree
                  {-# LINE 11392 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  DropFunction ann_ _ifEIoriginalTree _sigsIoriginalTree _cascadeIoriginalTree
                  {-# LINE 11397 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 11402 "AstInternal.hs" #-}
              -- copy rule (down)
              _ifEOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11407 "AstInternal.hs" #-}
              -- copy rule (down)
              _ifEOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 11412 "AstInternal.hs" #-}
              -- copy rule (down)
              _sigsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11417 "AstInternal.hs" #-}
              -- copy rule (down)
              _sigsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 11422 "AstInternal.hs" #-}
              -- copy rule (down)
              _cascadeOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11427 "AstInternal.hs" #-}
              -- copy rule (down)
              _cascadeOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 11432 "AstInternal.hs" #-}
              ( _ifEIannotatedTree,_ifEIoriginalTree) =
                  (ifE_ _ifEOcat _ifEOlib )
              ( _sigsIannotatedTree,_sigsIfnSigs,_sigsIoriginalTree) =
                  (sigs_ _sigsOcat _sigsOlib )
              ( _cascadeIannotatedTree,_cascadeIoriginalTree) =
                  (cascade_ _cascadeOcat _cascadeOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_DropSomething :: Annotation ->
                               T_DropType  ->
                               T_IfExists  ->
                               T_StringList  ->
                               T_Cascade  ->
                               T_Statement 
sem_Statement_DropSomething ann_ dropType_ ifE_ names_ cascade_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              _dropTypeOcat :: Catalog
              _dropTypeOlib :: LocalBindings
              _ifEOcat :: Catalog
              _ifEOlib :: LocalBindings
              _namesOcat :: Catalog
              _namesOlib :: LocalBindings
              _cascadeOcat :: Catalog
              _cascadeOlib :: LocalBindings
              _dropTypeIannotatedTree :: DropType
              _dropTypeIoriginalTree :: DropType
              _ifEIannotatedTree :: IfExists
              _ifEIoriginalTree :: IfExists
              _namesIannotatedTree :: StringList
              _namesIoriginalTree :: StringList
              _namesIstrings :: ([String])
              _cascadeIannotatedTree :: Cascade
              _cascadeIoriginalTree :: Cascade
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 11475 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 11480 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  DropSomething ann_ _dropTypeIannotatedTree _ifEIannotatedTree _namesIannotatedTree _cascadeIannotatedTree
                  {-# LINE 11485 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  DropSomething ann_ _dropTypeIoriginalTree _ifEIoriginalTree _namesIoriginalTree _cascadeIoriginalTree
                  {-# LINE 11490 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 11495 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 11500 "AstInternal.hs" #-}
              -- copy rule (down)
              _dropTypeOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11505 "AstInternal.hs" #-}
              -- copy rule (down)
              _dropTypeOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 11510 "AstInternal.hs" #-}
              -- copy rule (down)
              _ifEOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11515 "AstInternal.hs" #-}
              -- copy rule (down)
              _ifEOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 11520 "AstInternal.hs" #-}
              -- copy rule (down)
              _namesOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11525 "AstInternal.hs" #-}
              -- copy rule (down)
              _namesOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 11530 "AstInternal.hs" #-}
              -- copy rule (down)
              _cascadeOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11535 "AstInternal.hs" #-}
              -- copy rule (down)
              _cascadeOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 11540 "AstInternal.hs" #-}
              ( _dropTypeIannotatedTree,_dropTypeIoriginalTree) =
                  (dropType_ _dropTypeOcat _dropTypeOlib )
              ( _ifEIannotatedTree,_ifEIoriginalTree) =
                  (ifE_ _ifEOcat _ifEOlib )
              ( _namesIannotatedTree,_namesIoriginalTree,_namesIstrings) =
                  (names_ _namesOcat _namesOlib )
              ( _cascadeIannotatedTree,_cascadeIoriginalTree) =
                  (cascade_ _cascadeOcat _cascadeOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_Execute :: Annotation ->
                         T_Expression  ->
                         T_Statement 
sem_Statement_Execute ann_ expr_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              _exprOcat :: Catalog
              _exprOlib :: LocalBindings
              _exprIannotatedTree :: Expression
              _exprIliftedColumnName :: String
              _exprIoriginalTree :: Expression
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 11570 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 11575 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Execute ann_ _exprIannotatedTree
                  {-# LINE 11580 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Execute ann_ _exprIoriginalTree
                  {-# LINE 11585 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 11590 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 11595 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11600 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 11605 "AstInternal.hs" #-}
              ( _exprIannotatedTree,_exprIliftedColumnName,_exprIoriginalTree) =
                  (expr_ _exprOcat _exprOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_ExecuteInto :: Annotation ->
                             T_Expression  ->
                             T_StringList  ->
                             T_Statement 
sem_Statement_ExecuteInto ann_ expr_ targets_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              _exprOcat :: Catalog
              _exprOlib :: LocalBindings
              _targetsOcat :: Catalog
              _targetsOlib :: LocalBindings
              _exprIannotatedTree :: Expression
              _exprIliftedColumnName :: String
              _exprIoriginalTree :: Expression
              _targetsIannotatedTree :: StringList
              _targetsIoriginalTree :: StringList
              _targetsIstrings :: ([String])
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 11635 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 11640 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  ExecuteInto ann_ _exprIannotatedTree _targetsIannotatedTree
                  {-# LINE 11645 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  ExecuteInto ann_ _exprIoriginalTree _targetsIoriginalTree
                  {-# LINE 11650 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 11655 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 11660 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11665 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 11670 "AstInternal.hs" #-}
              -- copy rule (down)
              _targetsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11675 "AstInternal.hs" #-}
              -- copy rule (down)
              _targetsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 11680 "AstInternal.hs" #-}
              ( _exprIannotatedTree,_exprIliftedColumnName,_exprIoriginalTree) =
                  (expr_ _exprOcat _exprOlib )
              ( _targetsIannotatedTree,_targetsIoriginalTree,_targetsIstrings) =
                  (targets_ _targetsOcat _targetsOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_ForIntegerStatement :: Annotation ->
                                     String ->
                                     T_Expression  ->
                                     T_Expression  ->
                                     T_StatementList  ->
                                     T_Statement 
sem_Statement_ForIntegerStatement ann_ var_ from_ to_ sts_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Statement
              _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _stsOcatUpdates :: ([CatalogUpdate])
              _stsOlibUpdates :: ([LocalBindingsUpdate])
              _tpe :: (Either [TypeError] Type)
              _stsOlib :: LocalBindings
              _catUpdates :: ([CatalogUpdate])
              _lhsOoriginalTree :: Statement
              _fromOcat :: Catalog
              _fromOlib :: LocalBindings
              _toOcat :: Catalog
              _toOlib :: LocalBindings
              _stsOcat :: Catalog
              _fromIannotatedTree :: Expression
              _fromIliftedColumnName :: String
              _fromIoriginalTree :: Expression
              _toIannotatedTree :: Expression
              _toIliftedColumnName :: String
              _toIoriginalTree :: Expression
              _stsIannotatedTree :: StatementList
              _stsIoriginalTree :: StatementList
              _stsIproducedCat :: Catalog
              _stsIproducedLib :: LocalBindings
              -- "./TypeChecking/Statements.ag"(line 61, column 9)
              _lhsOannotatedTree =
                  {-# LINE 61 "./TypeChecking/Statements.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ Just (map StatementTypeA _statementType     ++
                            [CatUpdates _catUpdates    ])
                  {-# LINE 11728 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 67, column 9)
              _lhsOcatUpdates =
                  {-# LINE 67 "./TypeChecking/Statements.ag" #-}
                  _catUpdates
                  {-# LINE 11733 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 68, column 9)
              _lhsOlibUpdates =
                  {-# LINE 68 "./TypeChecking/Statements.ag" #-}
                  _libUpdates
                  {-# LINE 11738 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 11743 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 110, column 9)
              _stsOcatUpdates =
                  {-# LINE 110 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 11748 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 111, column 9)
              _stsOlibUpdates =
                  {-# LINE 111 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 11753 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 36, column 9)
              _varTypeE =
                  {-# LINE 36 "./TypeChecking/Plpgsql.ag" #-}
                  lbLookupID _lhsIlib var_
                  {-# LINE 11758 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 37, column 9)
              _tpe =
                  {-# LINE 37 "./TypeChecking/Plpgsql.ag" #-}
                  do
                  let fromType = getTypeAnnotation _fromIannotatedTree
                      toType = getTypeAnnotation _toIannotatedTree
                  dependsOnRTpe [fromType,toType] $ do
                  errorWhen (fromType /= toType) [FromToTypesNotSame fromType toType]
                  case _varTypeE     of
                    Right t -> checkAssignmentValid _lhsIcat fromType t
                    Left _ -> return ()
                  return $ Pseudo Void
                  {-# LINE 11771 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 48, column 9)
              _stsOlib =
                  {-# LINE 48 "./TypeChecking/Plpgsql.ag" #-}
                  case _varTypeE     of
                    Left [UnrecognisedIdentifier var_] ->
                        fromRight _lhsIlib $
                        lbUpdate _lhsIcat _lhsIlib $
                          LBIds "local for loop variable" ""
                             [(var_,getTypeAnnotation _fromIannotatedTree)] []
                    _ -> _lhsIlib
                  {-# LINE 11782 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 57, column 9)
              _backTree =
                  {-# LINE 57 "./TypeChecking/Plpgsql.ag" #-}
                  ForIntegerStatement ann_ var_ _fromIannotatedTree _toIannotatedTree _stsIannotatedTree
                  {-# LINE 11787 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 58, column 9)
              _catUpdates =
                  {-# LINE 58 "./TypeChecking/Plpgsql.ag" #-}
                  []
                  {-# LINE 11792 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 59, column 9)
              _statementType =
                  {-# LINE 59 "./TypeChecking/Plpgsql.ag" #-}
                  []
                  {-# LINE 11797 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  ForIntegerStatement ann_ var_ _fromIannotatedTree _toIannotatedTree _stsIannotatedTree
                  {-# LINE 11802 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  ForIntegerStatement ann_ var_ _fromIoriginalTree _toIoriginalTree _stsIoriginalTree
                  {-# LINE 11807 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 11812 "AstInternal.hs" #-}
              -- copy rule (down)
              _fromOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11817 "AstInternal.hs" #-}
              -- copy rule (down)
              _fromOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 11822 "AstInternal.hs" #-}
              -- copy rule (down)
              _toOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11827 "AstInternal.hs" #-}
              -- copy rule (down)
              _toOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 11832 "AstInternal.hs" #-}
              -- copy rule (down)
              _stsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11837 "AstInternal.hs" #-}
              ( _fromIannotatedTree,_fromIliftedColumnName,_fromIoriginalTree) =
                  (from_ _fromOcat _fromOlib )
              ( _toIannotatedTree,_toIliftedColumnName,_toIoriginalTree) =
                  (to_ _toOcat _toOlib )
              ( _stsIannotatedTree,_stsIoriginalTree,_stsIproducedCat,_stsIproducedLib) =
                  (sts_ _stsOcat _stsOcatUpdates _stsOlib _stsOlibUpdates )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_ForSelectStatement :: Annotation ->
                                    String ->
                                    T_SelectExpression  ->
                                    T_StatementList  ->
                                    T_Statement 
sem_Statement_ForSelectStatement ann_ var_ sel_ sts_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Statement
              _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _stsOcatUpdates :: ([CatalogUpdate])
              _stsOlibUpdates :: ([LocalBindingsUpdate])
              _tpe :: (Either [TypeError] Type)
              _stsOlib :: LocalBindings
              _catUpdates :: ([CatalogUpdate])
              _lhsOoriginalTree :: Statement
              _selOcat :: Catalog
              _selOlib :: LocalBindings
              _stsOcat :: Catalog
              _selIannotatedTree :: SelectExpression
              _selIlibUpdates :: ([LocalBindingsUpdate])
              _selIoriginalTree :: SelectExpression
              _stsIannotatedTree :: StatementList
              _stsIoriginalTree :: StatementList
              _stsIproducedCat :: Catalog
              _stsIproducedLib :: LocalBindings
              -- "./TypeChecking/Statements.ag"(line 61, column 9)
              _lhsOannotatedTree =
                  {-# LINE 61 "./TypeChecking/Statements.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ Just (map StatementTypeA _statementType     ++
                            [CatUpdates _catUpdates    ])
                  {-# LINE 11881 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 67, column 9)
              _lhsOcatUpdates =
                  {-# LINE 67 "./TypeChecking/Statements.ag" #-}
                  _catUpdates
                  {-# LINE 11886 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 68, column 9)
              _lhsOlibUpdates =
                  {-# LINE 68 "./TypeChecking/Statements.ag" #-}
                  _libUpdates
                  {-# LINE 11891 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 11896 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 110, column 9)
              _stsOcatUpdates =
                  {-# LINE 110 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 11901 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 111, column 9)
              _stsOlibUpdates =
                  {-# LINE 111 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 11906 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 64, column 9)
              _selType =
                  {-# LINE 64 "./TypeChecking/Plpgsql.ag" #-}
                  getTypeAnnotation _selIannotatedTree
                  {-# LINE 11911 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 65, column 9)
              _tpe =
                  {-# LINE 65 "./TypeChecking/Plpgsql.ag" #-}
                  do
                  dependsOnRTpe [_selType    ] $ do
                  toType <- lbLookupID _lhsIlib var_
                  dependsOnRTpe [toType] $ do
                  checkAssignmentValid _lhsIcat _selType     toType
                  return $ Pseudo Void
                  {-# LINE 11921 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 76, column 9)
              _stsOlib =
                  {-# LINE 76 "./TypeChecking/Plpgsql.ag" #-}
                  if okToUpdate
                    then fromRight _lhsIlib $
                         lbUpdate _lhsIcat _lhsIlib $
                           LBIds "for loop record type" ""
                                            [(var_,_selType    )] []
                    else _lhsIlib
                  where
                    okToUpdate = isRight _tpe     && _selType     /= TypeCheckFailed
                  {-# LINE 11933 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 87, column 9)
              _backTree =
                  {-# LINE 87 "./TypeChecking/Plpgsql.ag" #-}
                  ForSelectStatement ann_ var_ _selIannotatedTree _stsIannotatedTree
                  {-# LINE 11938 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 88, column 9)
              _catUpdates =
                  {-# LINE 88 "./TypeChecking/Plpgsql.ag" #-}
                  []
                  {-# LINE 11943 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 89, column 9)
              _statementType =
                  {-# LINE 89 "./TypeChecking/Plpgsql.ag" #-}
                  []
                  {-# LINE 11948 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  ForSelectStatement ann_ var_ _selIannotatedTree _stsIannotatedTree
                  {-# LINE 11953 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  ForSelectStatement ann_ var_ _selIoriginalTree _stsIoriginalTree
                  {-# LINE 11958 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 11963 "AstInternal.hs" #-}
              -- copy rule (down)
              _selOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11968 "AstInternal.hs" #-}
              -- copy rule (down)
              _selOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 11973 "AstInternal.hs" #-}
              -- copy rule (down)
              _stsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 11978 "AstInternal.hs" #-}
              ( _selIannotatedTree,_selIlibUpdates,_selIoriginalTree) =
                  (sel_ _selOcat _selOlib )
              ( _stsIannotatedTree,_stsIoriginalTree,_stsIproducedCat,_stsIproducedLib) =
                  (sts_ _stsOcat _stsOcatUpdates _stsOlib _stsOlibUpdates )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_If :: Annotation ->
                    T_ExpressionStatementListPairList  ->
                    T_StatementList  ->
                    T_Statement 
sem_Statement_If ann_ cases_ els_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _elsOcatUpdates :: ([CatalogUpdate])
              _elsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              _casesOcat :: Catalog
              _casesOlib :: LocalBindings
              _elsOcat :: Catalog
              _elsOlib :: LocalBindings
              _casesIannotatedTree :: ExpressionStatementListPairList
              _casesIoriginalTree :: ExpressionStatementListPairList
              _elsIannotatedTree :: StatementList
              _elsIoriginalTree :: StatementList
              _elsIproducedCat :: Catalog
              _elsIproducedLib :: LocalBindings
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12012 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12017 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 106, column 9)
              _elsOcatUpdates =
                  {-# LINE 106 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12022 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 107, column 9)
              _elsOlibUpdates =
                  {-# LINE 107 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12027 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  If ann_ _casesIannotatedTree _elsIannotatedTree
                  {-# LINE 12032 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  If ann_ _casesIoriginalTree _elsIoriginalTree
                  {-# LINE 12037 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 12042 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 12047 "AstInternal.hs" #-}
              -- copy rule (down)
              _casesOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 12052 "AstInternal.hs" #-}
              -- copy rule (down)
              _casesOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 12057 "AstInternal.hs" #-}
              -- copy rule (down)
              _elsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 12062 "AstInternal.hs" #-}
              -- copy rule (down)
              _elsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 12067 "AstInternal.hs" #-}
              ( _casesIannotatedTree,_casesIoriginalTree) =
                  (cases_ _casesOcat _casesOlib )
              ( _elsIannotatedTree,_elsIoriginalTree,_elsIproducedCat,_elsIproducedLib) =
                  (els_ _elsOcat _elsOcatUpdates _elsOlib _elsOlibUpdates )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_Insert :: Annotation ->
                        String ->
                        T_StringList  ->
                        T_SelectExpression  ->
                        T_MaybeSelectList  ->
                        T_Statement 
sem_Statement_Insert ann_ table_ targetCols_ insData_ returning_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Statement
              _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _tpe :: (Either [TypeError] Type)
              _catUpdates :: ([CatalogUpdate])
              _returningOlib :: LocalBindings
              _lhsOoriginalTree :: Statement
              _targetColsOcat :: Catalog
              _targetColsOlib :: LocalBindings
              _insDataOcat :: Catalog
              _insDataOlib :: LocalBindings
              _returningOcat :: Catalog
              _targetColsIannotatedTree :: StringList
              _targetColsIoriginalTree :: StringList
              _targetColsIstrings :: ([String])
              _insDataIannotatedTree :: SelectExpression
              _insDataIlibUpdates :: ([LocalBindingsUpdate])
              _insDataIoriginalTree :: SelectExpression
              _returningIannotatedTree :: MaybeSelectList
              _returningIlistType :: (Maybe [(String,Type)])
              _returningIoriginalTree :: MaybeSelectList
              -- "./TypeChecking/Statements.ag"(line 61, column 9)
              _lhsOannotatedTree =
                  {-# LINE 61 "./TypeChecking/Statements.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ Just (map StatementTypeA _statementType     ++
                            [CatUpdates _catUpdates    ])
                  {-# LINE 12112 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 67, column 9)
              _lhsOcatUpdates =
                  {-# LINE 67 "./TypeChecking/Statements.ag" #-}
                  _catUpdates
                  {-# LINE 12117 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 68, column 9)
              _lhsOlibUpdates =
                  {-# LINE 68 "./TypeChecking/Statements.ag" #-}
                  _libUpdates
                  {-# LINE 12122 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12127 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 18, column 9)
              _tpe =
                  {-# LINE 18 "./TypeChecking/Dml.ag" #-}
                  dependsOnRTpe [getTypeAnnotation _insDataIannotatedTree] $ do
                    _columnTypes
                    Right $ Pseudo Void
                  {-# LINE 12134 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 22, column 9)
              _statementType =
                  {-# LINE 22 "./TypeChecking/Dml.ag" #-}
                  leftToEmpty (\ct -> [StatementType (getPlaceholderTypes _insDataAddedInferredTypes    ) (fromMaybe [] _returningIlistType)]) _columnTypes
                  {-# LINE 12139 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 25, column 9)
              _columnTypes =
                  {-# LINE 25 "./TypeChecking/Dml.ag" #-}
                  do
                  tys <- unwrapSetOfComposite $
                         getTypeAnnotation _insDataIannotatedTree
                  checkColumnConsistency _lhsIcat
                                         table_
                                         _targetColsIstrings
                                         tys
                  {-# LINE 12150 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 33, column 9)
              _insDataAddedInferredTypes =
                  {-# LINE 33 "./TypeChecking/Dml.ag" #-}
                  case _insDataIannotatedTree of
                    Values ann [exl] ->
                        let fargs = map snd (fromRight [] _columnTypes    ) ++ repeat TypeCheckFailed
                            newExl = map (\(ex,ty) -> updateAnnotation (++ [InferredType ty]) ex) $ zip exl fargs
                        in Values ann [newExl]
                    x -> x
                  {-# LINE 12160 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 41, column 9)
              _backTree =
                  {-# LINE 41 "./TypeChecking/Dml.ag" #-}
                  Insert ann_ table_ _targetColsIannotatedTree
                         _insDataAddedInferredTypes     _returningIannotatedTree
                  {-# LINE 12166 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 43, column 9)
              _catUpdates =
                  {-# LINE 43 "./TypeChecking/Dml.ag" #-}
                  []
                  {-# LINE 12171 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 49, column 9)
              _returningOlib =
                  {-# LINE 49 "./TypeChecking/Dml.ag" #-}
                  fromRight _lhsIlib $ do
                    atts <- catCompositeAttrs _lhsIcat relationComposites table_
                    lbUpdate _lhsIcat _lhsIlib $ LBIds "insert target table" "" atts []
                  {-# LINE 12178 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Insert ann_ table_ _targetColsIannotatedTree _insDataIannotatedTree _returningIannotatedTree
                  {-# LINE 12183 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Insert ann_ table_ _targetColsIoriginalTree _insDataIoriginalTree _returningIoriginalTree
                  {-# LINE 12188 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 12193 "AstInternal.hs" #-}
              -- copy rule (down)
              _targetColsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 12198 "AstInternal.hs" #-}
              -- copy rule (down)
              _targetColsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 12203 "AstInternal.hs" #-}
              -- copy rule (down)
              _insDataOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 12208 "AstInternal.hs" #-}
              -- copy rule (down)
              _insDataOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 12213 "AstInternal.hs" #-}
              -- copy rule (down)
              _returningOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 12218 "AstInternal.hs" #-}
              ( _targetColsIannotatedTree,_targetColsIoriginalTree,_targetColsIstrings) =
                  (targetCols_ _targetColsOcat _targetColsOlib )
              ( _insDataIannotatedTree,_insDataIlibUpdates,_insDataIoriginalTree) =
                  (insData_ _insDataOcat _insDataOlib )
              ( _returningIannotatedTree,_returningIlistType,_returningIoriginalTree) =
                  (returning_ _returningOcat _returningOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_Notify :: Annotation ->
                        String ->
                        T_Statement 
sem_Statement_Notify ann_ name_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12241 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12246 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12251 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Notify ann_ name_
                  {-# LINE 12256 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Notify ann_ name_
                  {-# LINE 12261 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 12266 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 12271 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_NullStatement :: Annotation ->
                               T_Statement 
sem_Statement_NullStatement ann_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12287 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12292 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  NullStatement ann_
                  {-# LINE 12297 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  NullStatement ann_
                  {-# LINE 12302 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 12307 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 12312 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_Perform :: Annotation ->
                         T_Expression  ->
                         T_Statement 
sem_Statement_Perform ann_ expr_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              _exprOcat :: Catalog
              _exprOlib :: LocalBindings
              _exprIannotatedTree :: Expression
              _exprIliftedColumnName :: String
              _exprIoriginalTree :: Expression
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12334 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12339 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Perform ann_ _exprIannotatedTree
                  {-# LINE 12344 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Perform ann_ _exprIoriginalTree
                  {-# LINE 12349 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 12354 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 12359 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 12364 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 12369 "AstInternal.hs" #-}
              ( _exprIannotatedTree,_exprIliftedColumnName,_exprIoriginalTree) =
                  (expr_ _exprOcat _exprOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_Raise :: Annotation ->
                       T_RaiseType  ->
                       String ->
                       T_ExpressionList  ->
                       T_Statement 
sem_Statement_Raise ann_ level_ message_ args_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              _levelOcat :: Catalog
              _levelOlib :: LocalBindings
              _argsOcat :: Catalog
              _argsOlib :: LocalBindings
              _levelIannotatedTree :: RaiseType
              _levelIoriginalTree :: RaiseType
              _argsIannotatedTree :: ExpressionList
              _argsIoriginalTree :: ExpressionList
              _argsItypeList :: ([Type])
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12399 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12404 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Raise ann_ _levelIannotatedTree message_ _argsIannotatedTree
                  {-# LINE 12409 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Raise ann_ _levelIoriginalTree message_ _argsIoriginalTree
                  {-# LINE 12414 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 12419 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 12424 "AstInternal.hs" #-}
              -- copy rule (down)
              _levelOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 12429 "AstInternal.hs" #-}
              -- copy rule (down)
              _levelOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 12434 "AstInternal.hs" #-}
              -- copy rule (down)
              _argsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 12439 "AstInternal.hs" #-}
              -- copy rule (down)
              _argsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 12444 "AstInternal.hs" #-}
              ( _levelIannotatedTree,_levelIoriginalTree) =
                  (level_ _levelOcat _levelOlib )
              ( _argsIannotatedTree,_argsIoriginalTree,_argsItypeList) =
                  (args_ _argsOcat _argsOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_Return :: Annotation ->
                        T_MaybeExpression  ->
                        T_Statement 
sem_Statement_Return ann_ value_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Statement
              _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _tpe :: (Either [TypeError] Type)
              _catUpdates :: ([CatalogUpdate])
              _lhsOoriginalTree :: Statement
              _valueOcat :: Catalog
              _valueOlib :: LocalBindings
              _valueIannotatedTree :: MaybeExpression
              _valueIoriginalTree :: MaybeExpression
              -- "./TypeChecking/Statements.ag"(line 61, column 9)
              _lhsOannotatedTree =
                  {-# LINE 61 "./TypeChecking/Statements.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ Just (map StatementTypeA _statementType     ++
                            [CatUpdates _catUpdates    ])
                  {-# LINE 12475 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 67, column 9)
              _lhsOcatUpdates =
                  {-# LINE 67 "./TypeChecking/Statements.ag" #-}
                  _catUpdates
                  {-# LINE 12480 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 68, column 9)
              _lhsOlibUpdates =
                  {-# LINE 68 "./TypeChecking/Statements.ag" #-}
                  _libUpdates
                  {-# LINE 12485 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12490 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 12, column 9)
              _tpe =
                  {-# LINE 12 "./TypeChecking/Plpgsql.ag" #-}
                  dependsOnRTpe [maybe typeBool
                                      getTypeAnnotation
                                      _valueIannotatedTree] $ Right $ Pseudo Void
                  {-# LINE 12497 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 16, column 9)
              _backTree =
                  {-# LINE 16 "./TypeChecking/Plpgsql.ag" #-}
                  Return ann_ _valueIannotatedTree
                  {-# LINE 12502 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 17, column 9)
              _catUpdates =
                  {-# LINE 17 "./TypeChecking/Plpgsql.ag" #-}
                  []
                  {-# LINE 12507 "AstInternal.hs" #-}
              -- "./TypeChecking/Plpgsql.ag"(line 18, column 9)
              _statementType =
                  {-# LINE 18 "./TypeChecking/Plpgsql.ag" #-}
                  []
                  {-# LINE 12512 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Return ann_ _valueIannotatedTree
                  {-# LINE 12517 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Return ann_ _valueIoriginalTree
                  {-# LINE 12522 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 12527 "AstInternal.hs" #-}
              -- copy rule (down)
              _valueOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 12532 "AstInternal.hs" #-}
              -- copy rule (down)
              _valueOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 12537 "AstInternal.hs" #-}
              ( _valueIannotatedTree,_valueIoriginalTree) =
                  (value_ _valueOcat _valueOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_ReturnNext :: Annotation ->
                            T_Expression  ->
                            T_Statement 
sem_Statement_ReturnNext ann_ expr_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              _exprOcat :: Catalog
              _exprOlib :: LocalBindings
              _exprIannotatedTree :: Expression
              _exprIliftedColumnName :: String
              _exprIoriginalTree :: Expression
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12561 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12566 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  ReturnNext ann_ _exprIannotatedTree
                  {-# LINE 12571 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  ReturnNext ann_ _exprIoriginalTree
                  {-# LINE 12576 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 12581 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 12586 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 12591 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 12596 "AstInternal.hs" #-}
              ( _exprIannotatedTree,_exprIliftedColumnName,_exprIoriginalTree) =
                  (expr_ _exprOcat _exprOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_ReturnQuery :: Annotation ->
                             T_SelectExpression  ->
                             T_Statement 
sem_Statement_ReturnQuery ann_ sel_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              _selOcat :: Catalog
              _selOlib :: LocalBindings
              _selIannotatedTree :: SelectExpression
              _selIlibUpdates :: ([LocalBindingsUpdate])
              _selIoriginalTree :: SelectExpression
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12620 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12625 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  ReturnQuery ann_ _selIannotatedTree
                  {-# LINE 12630 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  ReturnQuery ann_ _selIoriginalTree
                  {-# LINE 12635 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 12640 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 12645 "AstInternal.hs" #-}
              -- copy rule (down)
              _selOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 12650 "AstInternal.hs" #-}
              -- copy rule (down)
              _selOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 12655 "AstInternal.hs" #-}
              ( _selIannotatedTree,_selIlibUpdates,_selIoriginalTree) =
                  (sel_ _selOcat _selOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_SelectStatement :: Annotation ->
                                 T_SelectExpression  ->
                                 T_Statement 
sem_Statement_SelectStatement ann_ ex_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Statement
              _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _tpe :: (Either [TypeError] Type)
              _catUpdates :: ([CatalogUpdate])
              _lhsOoriginalTree :: Statement
              _exOcat :: Catalog
              _exOlib :: LocalBindings
              _exIannotatedTree :: SelectExpression
              _exIlibUpdates :: ([LocalBindingsUpdate])
              _exIoriginalTree :: SelectExpression
              -- "./TypeChecking/Statements.ag"(line 61, column 9)
              _lhsOannotatedTree =
                  {-# LINE 61 "./TypeChecking/Statements.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ Just (map StatementTypeA _statementType     ++
                            [CatUpdates _catUpdates    ])
                  {-# LINE 12685 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 67, column 9)
              _lhsOcatUpdates =
                  {-# LINE 67 "./TypeChecking/Statements.ag" #-}
                  _catUpdates
                  {-# LINE 12690 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 68, column 9)
              _lhsOlibUpdates =
                  {-# LINE 68 "./TypeChecking/Statements.ag" #-}
                  _libUpdates
                  {-# LINE 12695 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectStatement.ag"(line 14, column 9)
              _tpe =
                  {-# LINE 14 "./TypeChecking/SelectStatement.ag" #-}
                  dependsOnRTpe [getTypeAnnotation _exIannotatedTree] $ Right $ Pseudo Void
                  {-# LINE 12700 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectStatement.ag"(line 15, column 9)
              _statementType =
                  {-# LINE 15 "./TypeChecking/SelectStatement.ag" #-}
                  [StatementType (getPlaceholderTypes _exIannotatedTree) $ leftToEmpty id  $
                                      unwrapSetOfComposite $
                                      getTypeAnnotation _exIannotatedTree]
                  {-# LINE 12707 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectStatement.ag"(line 18, column 9)
              _backTree =
                  {-# LINE 18 "./TypeChecking/SelectStatement.ag" #-}
                  SelectStatement ann_ _exIannotatedTree
                  {-# LINE 12712 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectStatement.ag"(line 19, column 9)
              _catUpdates =
                  {-# LINE 19 "./TypeChecking/SelectStatement.ag" #-}
                  []
                  {-# LINE 12717 "AstInternal.hs" #-}
              -- "./TypeChecking/SelectLists.ag"(line 80, column 9)
              _libUpdates =
                  {-# LINE 80 "./TypeChecking/SelectLists.ag" #-}
                  _exIlibUpdates
                  {-# LINE 12722 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  SelectStatement ann_ _exIannotatedTree
                  {-# LINE 12727 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  SelectStatement ann_ _exIoriginalTree
                  {-# LINE 12732 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 12737 "AstInternal.hs" #-}
              -- copy rule (down)
              _exOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 12742 "AstInternal.hs" #-}
              -- copy rule (down)
              _exOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 12747 "AstInternal.hs" #-}
              ( _exIannotatedTree,_exIlibUpdates,_exIoriginalTree) =
                  (ex_ _exOcat _exOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_Set :: Annotation ->
                     String ->
                     ([SetValue]) ->
                     T_Statement 
sem_Statement_Set ann_ name_ values_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12767 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12772 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12777 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Set ann_ name_ values_
                  {-# LINE 12782 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Set ann_ name_ values_
                  {-# LINE 12787 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 12792 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 12797 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_Truncate :: Annotation ->
                          T_StringList  ->
                          T_RestartIdentity  ->
                          T_Cascade  ->
                          T_Statement 
sem_Statement_Truncate ann_ tables_ restartIdentity_ cascade_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              _tablesOcat :: Catalog
              _tablesOlib :: LocalBindings
              _restartIdentityOcat :: Catalog
              _restartIdentityOlib :: LocalBindings
              _cascadeOcat :: Catalog
              _cascadeOlib :: LocalBindings
              _tablesIannotatedTree :: StringList
              _tablesIoriginalTree :: StringList
              _tablesIstrings :: ([String])
              _restartIdentityIannotatedTree :: RestartIdentity
              _restartIdentityIoriginalTree :: RestartIdentity
              _cascadeIannotatedTree :: Cascade
              _cascadeIoriginalTree :: Cascade
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12829 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12834 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Truncate ann_ _tablesIannotatedTree _restartIdentityIannotatedTree _cascadeIannotatedTree
                  {-# LINE 12839 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Truncate ann_ _tablesIoriginalTree _restartIdentityIoriginalTree _cascadeIoriginalTree
                  {-# LINE 12844 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 12849 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 12854 "AstInternal.hs" #-}
              -- copy rule (down)
              _tablesOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 12859 "AstInternal.hs" #-}
              -- copy rule (down)
              _tablesOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 12864 "AstInternal.hs" #-}
              -- copy rule (down)
              _restartIdentityOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 12869 "AstInternal.hs" #-}
              -- copy rule (down)
              _restartIdentityOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 12874 "AstInternal.hs" #-}
              -- copy rule (down)
              _cascadeOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 12879 "AstInternal.hs" #-}
              -- copy rule (down)
              _cascadeOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 12884 "AstInternal.hs" #-}
              ( _tablesIannotatedTree,_tablesIoriginalTree,_tablesIstrings) =
                  (tables_ _tablesOcat _tablesOlib )
              ( _restartIdentityIannotatedTree,_restartIdentityIoriginalTree) =
                  (restartIdentity_ _restartIdentityOcat _restartIdentityOlib )
              ( _cascadeIannotatedTree,_cascadeIoriginalTree) =
                  (cascade_ _cascadeOcat _cascadeOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_Update :: Annotation ->
                        String ->
                        T_SetClauseList  ->
                        T_MaybeBoolExpression  ->
                        T_MaybeSelectList  ->
                        T_Statement 
sem_Statement_Update ann_ table_ assigns_ whr_ returning_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Statement
              _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _tpe :: (Either [TypeError] Type)
              _assignWInferredTypes :: SetClauseList
              _catUpdates :: ([CatalogUpdate])
              _whrOlib :: LocalBindings
              _assignsOlib :: LocalBindings
              _returningOlib :: LocalBindings
              _lhsOoriginalTree :: Statement
              _assignsOcat :: Catalog
              _whrOcat :: Catalog
              _returningOcat :: Catalog
              _assignsIannotatedTree :: SetClauseList
              _assignsIoriginalTree :: SetClauseList
              _assignsIpairs :: ([(String,Type)])
              _assignsIrowSetErrors :: ([TypeError])
              _whrIannotatedTree :: MaybeBoolExpression
              _whrIoriginalTree :: MaybeBoolExpression
              _returningIannotatedTree :: MaybeSelectList
              _returningIlistType :: (Maybe [(String,Type)])
              _returningIoriginalTree :: MaybeSelectList
              -- "./TypeChecking/Statements.ag"(line 61, column 9)
              _lhsOannotatedTree =
                  {-# LINE 61 "./TypeChecking/Statements.ag" #-}
                  annTypesAndErrors _backTree
                    (tpeToT _tpe    )
                    (getErrors _tpe    )
                    $ Just (map StatementTypeA _statementType     ++
                            [CatUpdates _catUpdates    ])
                  {-# LINE 12932 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 67, column 9)
              _lhsOcatUpdates =
                  {-# LINE 67 "./TypeChecking/Statements.ag" #-}
                  _catUpdates
                  {-# LINE 12937 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 68, column 9)
              _lhsOlibUpdates =
                  {-# LINE 68 "./TypeChecking/Statements.ag" #-}
                  _libUpdates
                  {-# LINE 12942 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 73, column 9)
              _libUpdates =
                  {-# LINE 73 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 12947 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 65, column 9)
              _tpe =
                  {-# LINE 65 "./TypeChecking/Dml.ag" #-}
                  do
                  checkRelationExists _lhsIcat table_
                  dependsOnRTpe (map snd _assignsIpairs) $ do
                    _columnTypes
                    liftErrors _assignsIrowSetErrors
                    return $ Pseudo Void
                  {-# LINE 12957 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 72, column 9)
              _statementType =
                  {-# LINE 72 "./TypeChecking/Dml.ag" #-}
                  leftToEmpty (\ct -> [StatementType (getPlaceholderTypes _assignWInferredTypes
                                                      ++ getPlaceholderTypes _whrIannotatedTree)
                                                     (fromMaybe [] _returningIlistType)])
                     _columnTypes
                  {-# LINE 12965 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 78, column 9)
              _columnTypes =
                  {-# LINE 78 "./TypeChecking/Dml.ag" #-}
                  checkColumnConsistency _lhsIcat
                                         table_
                                         (map fst _assignsIpairs)
                                         _assignsIpairs
                  {-# LINE 12973 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 84, column 9)
              _assignWInferredTypes =
                  {-# LINE 84 "./TypeChecking/Dml.ag" #-}
                  let colTypes :: [Type]
                      colTypes = (map snd $ fromRight [] _columnTypes    )
                  in setInferredTypesG colTypes _assignsIannotatedTree
                  {-# LINE 12980 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 89, column 9)
              _backTree =
                  {-# LINE 89 "./TypeChecking/Dml.ag" #-}
                  Update ann_
                         table_
                         _assignWInferredTypes
                         _whrIannotatedTree
                         _returningIannotatedTree
                  {-# LINE 12989 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 94, column 9)
              _catUpdates =
                  {-# LINE 94 "./TypeChecking/Dml.ag" #-}
                  []
                  {-# LINE 12994 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 114, column 9)
              _lib =
                  {-# LINE 114 "./TypeChecking/Dml.ag" #-}
                  fromRight _lhsIlib $ do
                  ct <- catCompositeAttrs _lhsIcat
                                          relationComposites
                                          table_
                  lbUpdate _lhsIcat _lhsIlib $ LBIds "updated table attrs" "" ct []
                  {-# LINE 13003 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 120, column 9)
              _whrOlib =
                  {-# LINE 120 "./TypeChecking/Dml.ag" #-}
                  _lib
                  {-# LINE 13008 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 121, column 9)
              _assignsOlib =
                  {-# LINE 121 "./TypeChecking/Dml.ag" #-}
                  _lib
                  {-# LINE 13013 "AstInternal.hs" #-}
              -- "./TypeChecking/Dml.ag"(line 122, column 9)
              _returningOlib =
                  {-# LINE 122 "./TypeChecking/Dml.ag" #-}
                  _lib
                  {-# LINE 13018 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Update ann_ table_ _assignsIannotatedTree _whrIannotatedTree _returningIannotatedTree
                  {-# LINE 13023 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Update ann_ table_ _assignsIoriginalTree _whrIoriginalTree _returningIoriginalTree
                  {-# LINE 13028 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 13033 "AstInternal.hs" #-}
              -- copy rule (down)
              _assignsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 13038 "AstInternal.hs" #-}
              -- copy rule (down)
              _whrOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 13043 "AstInternal.hs" #-}
              -- copy rule (down)
              _returningOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 13048 "AstInternal.hs" #-}
              ( _assignsIannotatedTree,_assignsIoriginalTree,_assignsIpairs,_assignsIrowSetErrors) =
                  (assigns_ _assignsOcat _assignsOlib )
              ( _whrIannotatedTree,_whrIoriginalTree) =
                  (whr_ _whrOcat _whrOlib )
              ( _returningIannotatedTree,_returningIlistType,_returningIoriginalTree) =
                  (returning_ _returningOcat _returningOlib )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_Statement_WhileStatement :: Annotation ->
                                T_Expression  ->
                                T_StatementList  ->
                                T_Statement 
sem_Statement_WhileStatement ann_ expr_ sts_  =
    (\ _lhsIcat
       _lhsIinProducedCat
       _lhsIlib ->
         (let _lhsOcatUpdates :: ([CatalogUpdate])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _stsOcatUpdates :: ([CatalogUpdate])
              _stsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: Statement
              _lhsOoriginalTree :: Statement
              _exprOcat :: Catalog
              _exprOlib :: LocalBindings
              _stsOcat :: Catalog
              _stsOlib :: LocalBindings
              _exprIannotatedTree :: Expression
              _exprIliftedColumnName :: String
              _exprIoriginalTree :: Expression
              _stsIannotatedTree :: StatementList
              _stsIoriginalTree :: StatementList
              _stsIproducedCat :: Catalog
              _stsIproducedLib :: LocalBindings
              -- "./TypeChecking/Statements.ag"(line 89, column 9)
              _lhsOcatUpdates =
                  {-# LINE 89 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 13085 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 90, column 9)
              _lhsOlibUpdates =
                  {-# LINE 90 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 13090 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 110, column 9)
              _stsOcatUpdates =
                  {-# LINE 110 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 13095 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 111, column 9)
              _stsOlibUpdates =
                  {-# LINE 111 "./TypeChecking/Statements.ag" #-}
                  []
                  {-# LINE 13100 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  WhileStatement ann_ _exprIannotatedTree _stsIannotatedTree
                  {-# LINE 13105 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  WhileStatement ann_ _exprIoriginalTree _stsIoriginalTree
                  {-# LINE 13110 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 13115 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 13120 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 13125 "AstInternal.hs" #-}
              -- copy rule (down)
              _exprOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 13130 "AstInternal.hs" #-}
              -- copy rule (down)
              _stsOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 13135 "AstInternal.hs" #-}
              -- copy rule (down)
              _stsOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 13140 "AstInternal.hs" #-}
              ( _exprIannotatedTree,_exprIliftedColumnName,_exprIoriginalTree) =
                  (expr_ _exprOcat _exprOlib )
              ( _stsIannotatedTree,_stsIoriginalTree,_stsIproducedCat,_stsIproducedLib) =
                  (sts_ _stsOcat _stsOcatUpdates _stsOlib _stsOlibUpdates )
          in  ( _lhsOannotatedTree,_lhsOcatUpdates,_lhsOlibUpdates,_lhsOoriginalTree)))
-- StatementList -----------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         catUpdates           : [CatalogUpdate]
         lib                  : LocalBindings
         libUpdates           : [LocalBindingsUpdate]
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
         producedCat          : Catalog
         producedLib          : LocalBindings
   alternatives:
      alternative Cons:
         child hd             : Statement 
         child tl             : StatementList 
         visit 0:
            local newCat      : _
            local newLib      : _
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local newCat      : _
            local newLib      : _
            local annotatedTree : _
            local originalTree : _
-}
type StatementList  = [(Statement)]
-- cata
sem_StatementList :: StatementList  ->
                     T_StatementList 
sem_StatementList list  =
    (Prelude.foldr sem_StatementList_Cons sem_StatementList_Nil (Prelude.map sem_Statement list) )
-- semantic domain
type T_StatementList  = Catalog ->
                        ([CatalogUpdate]) ->
                        LocalBindings ->
                        ([LocalBindingsUpdate]) ->
                        ( StatementList,StatementList,Catalog,LocalBindings)
data Inh_StatementList  = Inh_StatementList {cat_Inh_StatementList :: Catalog,catUpdates_Inh_StatementList :: [CatalogUpdate],lib_Inh_StatementList :: LocalBindings,libUpdates_Inh_StatementList :: [LocalBindingsUpdate]}
data Syn_StatementList  = Syn_StatementList {annotatedTree_Syn_StatementList :: StatementList,originalTree_Syn_StatementList :: StatementList,producedCat_Syn_StatementList :: Catalog,producedLib_Syn_StatementList :: LocalBindings}
wrap_StatementList :: T_StatementList  ->
                      Inh_StatementList  ->
                      Syn_StatementList 
wrap_StatementList sem (Inh_StatementList _lhsIcat _lhsIcatUpdates _lhsIlib _lhsIlibUpdates )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOproducedCat,_lhsOproducedLib) =
             (sem _lhsIcat _lhsIcatUpdates _lhsIlib _lhsIlibUpdates )
     in  (Syn_StatementList _lhsOannotatedTree _lhsOoriginalTree _lhsOproducedCat _lhsOproducedLib ))
sem_StatementList_Cons :: T_Statement  ->
                          T_StatementList  ->
                          T_StatementList 
sem_StatementList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIcatUpdates
       _lhsIlib
       _lhsIlibUpdates ->
         (let _hdOcat :: Catalog
              _tlOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOlib :: LocalBindings
              _lhsOproducedCat :: Catalog
              _lhsOproducedLib :: LocalBindings
              _tlOcatUpdates :: ([CatalogUpdate])
              _tlOlibUpdates :: ([LocalBindingsUpdate])
              _hdOinProducedCat :: Catalog
              _lhsOannotatedTree :: StatementList
              _lhsOoriginalTree :: StatementList
              _hdIannotatedTree :: Statement
              _hdIcatUpdates :: ([CatalogUpdate])
              _hdIlibUpdates :: ([LocalBindingsUpdate])
              _hdIoriginalTree :: Statement
              _tlIannotatedTree :: StatementList
              _tlIoriginalTree :: StatementList
              _tlIproducedCat :: Catalog
              _tlIproducedLib :: LocalBindings
              -- "./TypeChecking/Statements.ag"(line 36, column 9)
              _newCat =
                  {-# LINE 36 "./TypeChecking/Statements.ag" #-}
                  fromRight _lhsIcat $ updateCatalog _lhsIcat _lhsIcatUpdates
                  {-# LINE 13227 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 37, column 9)
              _newLib =
                  {-# LINE 37 "./TypeChecking/Statements.ag" #-}
                  fromRight _lhsIlib $ foldM (lbUpdate _lhsIcat) _lhsIlib _lhsIlibUpdates
                  {-# LINE 13232 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 39, column 9)
              _hdOcat =
                  {-# LINE 39 "./TypeChecking/Statements.ag" #-}
                  _newCat
                  {-# LINE 13237 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 40, column 9)
              _tlOcat =
                  {-# LINE 40 "./TypeChecking/Statements.ag" #-}
                  _newCat
                  {-# LINE 13242 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 41, column 9)
              _hdOlib =
                  {-# LINE 41 "./TypeChecking/Statements.ag" #-}
                  _newLib
                  {-# LINE 13247 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 42, column 9)
              _tlOlib =
                  {-# LINE 42 "./TypeChecking/Statements.ag" #-}
                  _newLib
                  {-# LINE 13252 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 46, column 9)
              _lhsOproducedCat =
                  {-# LINE 46 "./TypeChecking/Statements.ag" #-}
                  _tlIproducedCat
                  {-# LINE 13257 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 47, column 9)
              _lhsOproducedLib =
                  {-# LINE 47 "./TypeChecking/Statements.ag" #-}
                  _tlIproducedLib
                  {-# LINE 13262 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 50, column 9)
              _tlOcatUpdates =
                  {-# LINE 50 "./TypeChecking/Statements.ag" #-}
                  _hdIcatUpdates
                  {-# LINE 13267 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 51, column 9)
              _tlOlibUpdates =
                  {-# LINE 51 "./TypeChecking/Statements.ag" #-}
                  _hdIlibUpdates
                  {-# LINE 13272 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 76, column 12)
              _hdOinProducedCat =
                  {-# LINE 76 "./TypeChecking/Statements.ag" #-}
                  _tlIproducedCat
                  {-# LINE 13277 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 13282 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 13287 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 13292 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 13297 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdIcatUpdates,_hdIlibUpdates,_hdIoriginalTree) =
                  (hd_ _hdOcat _hdOinProducedCat _hdOlib )
              ( _tlIannotatedTree,_tlIoriginalTree,_tlIproducedCat,_tlIproducedLib) =
                  (tl_ _tlOcat _tlOcatUpdates _tlOlib _tlOlibUpdates )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOproducedCat,_lhsOproducedLib)))
sem_StatementList_Nil :: T_StatementList 
sem_StatementList_Nil  =
    (\ _lhsIcat
       _lhsIcatUpdates
       _lhsIlib
       _lhsIlibUpdates ->
         (let _lhsOproducedCat :: Catalog
              _lhsOproducedLib :: LocalBindings
              _lhsOannotatedTree :: StatementList
              _lhsOoriginalTree :: StatementList
              -- "./TypeChecking/Statements.ag"(line 36, column 9)
              _newCat =
                  {-# LINE 36 "./TypeChecking/Statements.ag" #-}
                  fromRight _lhsIcat $ updateCatalog _lhsIcat _lhsIcatUpdates
                  {-# LINE 13317 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 37, column 9)
              _newLib =
                  {-# LINE 37 "./TypeChecking/Statements.ag" #-}
                  fromRight _lhsIlib $ foldM (lbUpdate _lhsIcat) _lhsIlib _lhsIlibUpdates
                  {-# LINE 13322 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 53, column 9)
              _lhsOproducedCat =
                  {-# LINE 53 "./TypeChecking/Statements.ag" #-}
                  _newCat
                  {-# LINE 13327 "AstInternal.hs" #-}
              -- "./TypeChecking/Statements.ag"(line 54, column 9)
              _lhsOproducedLib =
                  {-# LINE 54 "./TypeChecking/Statements.ag" #-}
                  _newLib
                  {-# LINE 13332 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 13337 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 13342 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 13347 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 13352 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOproducedCat,_lhsOproducedLib)))
-- StringList --------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
         strings              : [String]
   alternatives:
      alternative Cons:
         child hd             : {String}
         child tl             : StringList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type StringList  = [(String)]
-- cata
sem_StringList :: StringList  ->
                  T_StringList 
sem_StringList list  =
    (Prelude.foldr sem_StringList_Cons sem_StringList_Nil list )
-- semantic domain
type T_StringList  = Catalog ->
                     LocalBindings ->
                     ( StringList,StringList,([String]))
data Inh_StringList  = Inh_StringList {cat_Inh_StringList :: Catalog,lib_Inh_StringList :: LocalBindings}
data Syn_StringList  = Syn_StringList {annotatedTree_Syn_StringList :: StringList,originalTree_Syn_StringList :: StringList,strings_Syn_StringList :: [String]}
wrap_StringList :: T_StringList  ->
                   Inh_StringList  ->
                   Syn_StringList 
wrap_StringList sem (Inh_StringList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOstrings) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_StringList _lhsOannotatedTree _lhsOoriginalTree _lhsOstrings ))
sem_StringList_Cons :: String ->
                       T_StringList  ->
                       T_StringList 
sem_StringList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOstrings :: ([String])
              _lhsOannotatedTree :: StringList
              _lhsOoriginalTree :: StringList
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _tlIannotatedTree :: StringList
              _tlIoriginalTree :: StringList
              _tlIstrings :: ([String])
              -- "./TypeChecking/Misc.ag"(line 67, column 10)
              _lhsOstrings =
                  {-# LINE 67 "./TypeChecking/Misc.ag" #-}
                  hd_ : _tlIstrings
                  {-# LINE 13413 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) hd_ _tlIannotatedTree
                  {-# LINE 13418 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) hd_ _tlIoriginalTree
                  {-# LINE 13423 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 13428 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 13433 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 13438 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 13443 "AstInternal.hs" #-}
              ( _tlIannotatedTree,_tlIoriginalTree,_tlIstrings) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOstrings)))
sem_StringList_Nil :: T_StringList 
sem_StringList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOstrings :: ([String])
              _lhsOannotatedTree :: StringList
              _lhsOoriginalTree :: StringList
              -- "./TypeChecking/Misc.ag"(line 68, column 9)
              _lhsOstrings =
                  {-# LINE 68 "./TypeChecking/Misc.ag" #-}
                  []
                  {-# LINE 13458 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 13463 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 13468 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 13473 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 13478 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree,_lhsOstrings)))
-- StringTypeNameListPair --------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         fnSig                : (String,[Type])
         originalTree         : SELF 
   alternatives:
      alternative Tuple:
         child x1             : {String}
         child x2             : TypeNameList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type StringTypeNameListPair  = ( (String),(TypeNameList))
-- cata
sem_StringTypeNameListPair :: StringTypeNameListPair  ->
                              T_StringTypeNameListPair 
sem_StringTypeNameListPair ( x1,x2)  =
    (sem_StringTypeNameListPair_Tuple x1 (sem_TypeNameList x2 ) )
-- semantic domain
type T_StringTypeNameListPair  = Catalog ->
                                 LocalBindings ->
                                 ( StringTypeNameListPair,((String,[Type])),StringTypeNameListPair)
data Inh_StringTypeNameListPair  = Inh_StringTypeNameListPair {cat_Inh_StringTypeNameListPair :: Catalog,lib_Inh_StringTypeNameListPair :: LocalBindings}
data Syn_StringTypeNameListPair  = Syn_StringTypeNameListPair {annotatedTree_Syn_StringTypeNameListPair :: StringTypeNameListPair,fnSig_Syn_StringTypeNameListPair :: (String,[Type]),originalTree_Syn_StringTypeNameListPair :: StringTypeNameListPair}
wrap_StringTypeNameListPair :: T_StringTypeNameListPair  ->
                               Inh_StringTypeNameListPair  ->
                               Syn_StringTypeNameListPair 
wrap_StringTypeNameListPair sem (Inh_StringTypeNameListPair _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOfnSig,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_StringTypeNameListPair _lhsOannotatedTree _lhsOfnSig _lhsOoriginalTree ))
sem_StringTypeNameListPair_Tuple :: String ->
                                    T_TypeNameList  ->
                                    T_StringTypeNameListPair 
sem_StringTypeNameListPair_Tuple x1_ x2_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOfnSig :: ((String,[Type]))
              _lhsOannotatedTree :: StringTypeNameListPair
              _lhsOoriginalTree :: StringTypeNameListPair
              _x2Ocat :: Catalog
              _x2Olib :: LocalBindings
              _x2IannotatedTree :: TypeNameList
              _x2InamedTypes :: ([Type])
              _x2IoriginalTree :: TypeNameList
              -- "./TypeChecking/Drops.ag"(line 25, column 13)
              _lhsOfnSig =
                  {-# LINE 25 "./TypeChecking/Drops.ag" #-}
                  (x1_, _x2InamedTypes)
                  {-# LINE 13535 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (x1_,_x2IannotatedTree)
                  {-# LINE 13540 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (x1_,_x2IoriginalTree)
                  {-# LINE 13545 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 13550 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 13555 "AstInternal.hs" #-}
              -- copy rule (down)
              _x2Ocat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 13560 "AstInternal.hs" #-}
              -- copy rule (down)
              _x2Olib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 13565 "AstInternal.hs" #-}
              ( _x2IannotatedTree,_x2InamedTypes,_x2IoriginalTree) =
                  (x2_ _x2Ocat _x2Olib )
          in  ( _lhsOannotatedTree,_lhsOfnSig,_lhsOoriginalTree)))
-- StringTypeNameListPairList ----------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         fnSigs               : [(String,[Type])]
         originalTree         : SELF 
   alternatives:
      alternative Cons:
         child hd             : StringTypeNameListPair 
         child tl             : StringTypeNameListPairList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type StringTypeNameListPairList  = [(StringTypeNameListPair)]
-- cata
sem_StringTypeNameListPairList :: StringTypeNameListPairList  ->
                                  T_StringTypeNameListPairList 
sem_StringTypeNameListPairList list  =
    (Prelude.foldr sem_StringTypeNameListPairList_Cons sem_StringTypeNameListPairList_Nil (Prelude.map sem_StringTypeNameListPair list) )
-- semantic domain
type T_StringTypeNameListPairList  = Catalog ->
                                     LocalBindings ->
                                     ( StringTypeNameListPairList,([(String,[Type])]),StringTypeNameListPairList)
data Inh_StringTypeNameListPairList  = Inh_StringTypeNameListPairList {cat_Inh_StringTypeNameListPairList :: Catalog,lib_Inh_StringTypeNameListPairList :: LocalBindings}
data Syn_StringTypeNameListPairList  = Syn_StringTypeNameListPairList {annotatedTree_Syn_StringTypeNameListPairList :: StringTypeNameListPairList,fnSigs_Syn_StringTypeNameListPairList :: [(String,[Type])],originalTree_Syn_StringTypeNameListPairList :: StringTypeNameListPairList}
wrap_StringTypeNameListPairList :: T_StringTypeNameListPairList  ->
                                   Inh_StringTypeNameListPairList  ->
                                   Syn_StringTypeNameListPairList 
wrap_StringTypeNameListPairList sem (Inh_StringTypeNameListPairList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOfnSigs,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_StringTypeNameListPairList _lhsOannotatedTree _lhsOfnSigs _lhsOoriginalTree ))
sem_StringTypeNameListPairList_Cons :: T_StringTypeNameListPair  ->
                                       T_StringTypeNameListPairList  ->
                                       T_StringTypeNameListPairList 
sem_StringTypeNameListPairList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOfnSigs :: ([(String,[Type])])
              _lhsOannotatedTree :: StringTypeNameListPairList
              _lhsOoriginalTree :: StringTypeNameListPairList
              _hdOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _hdIannotatedTree :: StringTypeNameListPair
              _hdIfnSig :: ((String,[Type]))
              _hdIoriginalTree :: StringTypeNameListPair
              _tlIannotatedTree :: StringTypeNameListPairList
              _tlIfnSigs :: ([(String,[Type])])
              _tlIoriginalTree :: StringTypeNameListPairList
              -- "./TypeChecking/Drops.ag"(line 20, column 12)
              _lhsOfnSigs =
                  {-# LINE 20 "./TypeChecking/Drops.ag" #-}
                  _hdIfnSig : _tlIfnSigs
                  {-# LINE 13633 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 13638 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 13643 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 13648 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 13653 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 13658 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 13663 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 13668 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 13673 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdIfnSig,_hdIoriginalTree) =
                  (hd_ _hdOcat _hdOlib )
              ( _tlIannotatedTree,_tlIfnSigs,_tlIoriginalTree) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOfnSigs,_lhsOoriginalTree)))
sem_StringTypeNameListPairList_Nil :: T_StringTypeNameListPairList 
sem_StringTypeNameListPairList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOfnSigs :: ([(String,[Type])])
              _lhsOannotatedTree :: StringTypeNameListPairList
              _lhsOoriginalTree :: StringTypeNameListPairList
              -- "./TypeChecking/Drops.ag"(line 21, column 11)
              _lhsOfnSigs =
                  {-# LINE 21 "./TypeChecking/Drops.ag" #-}
                  []
                  {-# LINE 13690 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 13695 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 13700 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 13705 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 13710 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOfnSigs,_lhsOoriginalTree)))
-- TableAlias --------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative FullAlias:
         child alias          : {String}
         child cols           : {[String]}
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative NoAlias:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative TableAlias:
         child alias          : {String}
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data TableAlias  = FullAlias (String) ([String]) 
                 | NoAlias 
                 | TableAlias (String) 
                 deriving ( Data,Eq,Show,Typeable)
-- cata
sem_TableAlias :: TableAlias  ->
                  T_TableAlias 
sem_TableAlias (FullAlias _alias _cols )  =
    (sem_TableAlias_FullAlias _alias _cols )
sem_TableAlias (NoAlias )  =
    (sem_TableAlias_NoAlias )
sem_TableAlias (TableAlias _alias )  =
    (sem_TableAlias_TableAlias _alias )
-- semantic domain
type T_TableAlias  = Catalog ->
                     LocalBindings ->
                     ( TableAlias,TableAlias)
data Inh_TableAlias  = Inh_TableAlias {cat_Inh_TableAlias :: Catalog,lib_Inh_TableAlias :: LocalBindings}
data Syn_TableAlias  = Syn_TableAlias {annotatedTree_Syn_TableAlias :: TableAlias,originalTree_Syn_TableAlias :: TableAlias}
wrap_TableAlias :: T_TableAlias  ->
                   Inh_TableAlias  ->
                   Syn_TableAlias 
wrap_TableAlias sem (Inh_TableAlias _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_TableAlias _lhsOannotatedTree _lhsOoriginalTree ))
sem_TableAlias_FullAlias :: String ->
                            ([String]) ->
                            T_TableAlias 
sem_TableAlias_FullAlias alias_ cols_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: TableAlias
              _lhsOoriginalTree :: TableAlias
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  FullAlias alias_ cols_
                  {-# LINE 13776 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  FullAlias alias_ cols_
                  {-# LINE 13781 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 13786 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 13791 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_TableAlias_NoAlias :: T_TableAlias 
sem_TableAlias_NoAlias  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: TableAlias
              _lhsOoriginalTree :: TableAlias
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  NoAlias
                  {-# LINE 13803 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  NoAlias
                  {-# LINE 13808 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 13813 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 13818 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_TableAlias_TableAlias :: String ->
                             T_TableAlias 
sem_TableAlias_TableAlias alias_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: TableAlias
              _lhsOoriginalTree :: TableAlias
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  TableAlias alias_
                  {-# LINE 13831 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  TableAlias alias_
                  {-# LINE 13836 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 13841 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 13846 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- TableRef ----------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         libUpdates           : [LocalBindingsUpdate]
         originalTree         : SELF 
   alternatives:
      alternative JoinedTref:
         child ann            : {Annotation}
         child tbl            : TableRef 
         child nat            : Natural 
         child joinType       : JoinType 
         child tbl1           : TableRef 
         child onExpr         : OnExpr 
         child alias          : TableAlias 
         visit 0:
            local errs        : _
            local joinErrors  : _
            local libUpdates  : _
            local newLib      : {Either [TypeError] LocalBindings}
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative SubTref:
         child ann            : {Annotation}
         child sel            : SelectExpression 
         child alias          : TableAlias 
         visit 0:
            local errs        : _
            local selectAttrs : {Either [TypeError] [(String,Type)]}
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative Tref:
         child ann            : {Annotation}
         child tbl            : {String}
         child alias          : TableAlias 
         visit 0:
            local errs        : _
            local relType     : {Either [TypeError] ([(String, Type)], [(String, Type)])}
            local relType1    : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative TrefFun:
         child ann            : {Annotation}
         child fn             : Expression 
         child alias          : TableAlias 
         visit 0:
            local errs        : _
            local eqfunIdens  : {Either [TypeError] (String,[(String,Type)])}
            local qfunIdens   : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
-}
data TableRef  = JoinedTref (Annotation) (TableRef) (Natural) (JoinType) (TableRef) (OnExpr) (TableAlias) 
               | SubTref (Annotation) (SelectExpression) (TableAlias) 
               | Tref (Annotation) (String) (TableAlias) 
               | TrefFun (Annotation) (Expression) (TableAlias) 
               deriving ( Data,Eq,Show,Typeable)
-- cata
sem_TableRef :: TableRef  ->
                T_TableRef 
sem_TableRef (JoinedTref _ann _tbl _nat _joinType _tbl1 _onExpr _alias )  =
    (sem_TableRef_JoinedTref _ann (sem_TableRef _tbl ) (sem_Natural _nat ) (sem_JoinType _joinType ) (sem_TableRef _tbl1 ) (sem_OnExpr _onExpr ) (sem_TableAlias _alias ) )
sem_TableRef (SubTref _ann _sel _alias )  =
    (sem_TableRef_SubTref _ann (sem_SelectExpression _sel ) (sem_TableAlias _alias ) )
sem_TableRef (Tref _ann _tbl _alias )  =
    (sem_TableRef_Tref _ann _tbl (sem_TableAlias _alias ) )
sem_TableRef (TrefFun _ann _fn _alias )  =
    (sem_TableRef_TrefFun _ann (sem_Expression _fn ) (sem_TableAlias _alias ) )
-- semantic domain
type T_TableRef  = Catalog ->
                   LocalBindings ->
                   ( TableRef,([LocalBindingsUpdate]),TableRef)
data Inh_TableRef  = Inh_TableRef {cat_Inh_TableRef :: Catalog,lib_Inh_TableRef :: LocalBindings}
data Syn_TableRef  = Syn_TableRef {annotatedTree_Syn_TableRef :: TableRef,libUpdates_Syn_TableRef :: [LocalBindingsUpdate],originalTree_Syn_TableRef :: TableRef}
wrap_TableRef :: T_TableRef  ->
                 Inh_TableRef  ->
                 Syn_TableRef 
wrap_TableRef sem (Inh_TableRef _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOlibUpdates,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_TableRef _lhsOannotatedTree _lhsOlibUpdates _lhsOoriginalTree ))
sem_TableRef_JoinedTref :: Annotation ->
                           T_TableRef  ->
                           T_Natural  ->
                           T_JoinType  ->
                           T_TableRef  ->
                           T_OnExpr  ->
                           T_TableAlias  ->
                           T_TableRef 
sem_TableRef_JoinedTref ann_ tbl_ nat_ joinType_ tbl1_ onExpr_ alias_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: TableRef
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _newLib :: (Either [TypeError] LocalBindings)
              _onExprOlib :: LocalBindings
              _lhsOoriginalTree :: TableRef
              _tblOcat :: Catalog
              _tblOlib :: LocalBindings
              _natOcat :: Catalog
              _natOlib :: LocalBindings
              _joinTypeOcat :: Catalog
              _joinTypeOlib :: LocalBindings
              _tbl1Ocat :: Catalog
              _tbl1Olib :: LocalBindings
              _onExprOcat :: Catalog
              _aliasOcat :: Catalog
              _aliasOlib :: LocalBindings
              _tblIannotatedTree :: TableRef
              _tblIlibUpdates :: ([LocalBindingsUpdate])
              _tblIoriginalTree :: TableRef
              _natIannotatedTree :: Natural
              _natIoriginalTree :: Natural
              _joinTypeIannotatedTree :: JoinType
              _joinTypeIoriginalTree :: JoinType
              _tbl1IannotatedTree :: TableRef
              _tbl1IlibUpdates :: ([LocalBindingsUpdate])
              _tbl1IoriginalTree :: TableRef
              _onExprIannotatedTree :: OnExpr
              _onExprIoriginalTree :: OnExpr
              _aliasIannotatedTree :: TableAlias
              _aliasIoriginalTree :: TableAlias
              -- "./TypeChecking/TableRefs.ag"(line 91, column 9)
              _lhsOannotatedTree =
                  {-# LINE 91 "./TypeChecking/TableRefs.ag" #-}
                  updateAnnotation (map TypeErrorA _errs     ++) _backTree
                  {-# LINE 13982 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 183, column 9)
              _errs =
                  {-# LINE 183 "./TypeChecking/TableRefs.ag" #-}
                  fromLeft [] _newLib
                  ++ _joinErrors
                  {-# LINE 13988 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 185, column 9)
              _lhsOlibUpdates =
                  {-# LINE 185 "./TypeChecking/TableRefs.ag" #-}
                  if _joinErrors     == []
                  then _libUpdates
                  else []
                  {-# LINE 13995 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 190, column 9)
              _joinErrors =
                  {-# LINE 190 "./TypeChecking/TableRefs.ag" #-}
                  fromLeft [] (foldM (lbUpdate _lhsIcat) _lhsIlib _libUpdates    )
                  {-# LINE 14000 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 191, column 9)
              _libUpdates =
                  {-# LINE 191 "./TypeChecking/TableRefs.ag" #-}
                  let [u1] = _tblIlibUpdates
                      [u2] = _tbl1IlibUpdates
                  in [LBJoinIds u1 u2 jids (case _aliasIannotatedTree of
                                              NoAlias -> ""
                                              TableAlias t -> t
                                              FullAlias t _ -> t)]
                  where
                    jids = case (_natIannotatedTree, _onExprIoriginalTree) of
                                (Natural, _) -> Left ()
                                (_,Just (JoinUsing _ s)) -> Right s
                                _ -> Right []
                  {-# LINE 14015 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 204, column 9)
              _newLib =
                  {-# LINE 204 "./TypeChecking/TableRefs.ag" #-}
                  let [u1] = _tblIlibUpdates
                      [u2] = _tbl1IlibUpdates
                  in lbUpdate _lhsIcat _lhsIlib (LBParallel u1 u2)
                  {-# LINE 14022 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 207, column 9)
              _onExprOlib =
                  {-# LINE 207 "./TypeChecking/TableRefs.ag" #-}
                  trace ("set on expression\n" ++ either show ppLocalBindings _newLib    ) $ fromRight _lhsIlib _newLib
                  {-# LINE 14027 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 265, column 9)
              _backTree =
                  {-# LINE 265 "./TypeChecking/TableRefs.ag" #-}
                  JoinedTref ann_
                             _tblIannotatedTree
                             _natIannotatedTree
                             _joinTypeIannotatedTree
                             _tbl1IannotatedTree
                             _onExprIannotatedTree
                             _aliasIannotatedTree
                  {-# LINE 14038 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  JoinedTref ann_ _tblIannotatedTree _natIannotatedTree _joinTypeIannotatedTree _tbl1IannotatedTree _onExprIannotatedTree _aliasIannotatedTree
                  {-# LINE 14043 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  JoinedTref ann_ _tblIoriginalTree _natIoriginalTree _joinTypeIoriginalTree _tbl1IoriginalTree _onExprIoriginalTree _aliasIoriginalTree
                  {-# LINE 14048 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 14053 "AstInternal.hs" #-}
              -- copy rule (down)
              _tblOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 14058 "AstInternal.hs" #-}
              -- copy rule (down)
              _tblOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 14063 "AstInternal.hs" #-}
              -- copy rule (down)
              _natOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 14068 "AstInternal.hs" #-}
              -- copy rule (down)
              _natOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 14073 "AstInternal.hs" #-}
              -- copy rule (down)
              _joinTypeOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 14078 "AstInternal.hs" #-}
              -- copy rule (down)
              _joinTypeOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 14083 "AstInternal.hs" #-}
              -- copy rule (down)
              _tbl1Ocat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 14088 "AstInternal.hs" #-}
              -- copy rule (down)
              _tbl1Olib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 14093 "AstInternal.hs" #-}
              -- copy rule (down)
              _onExprOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 14098 "AstInternal.hs" #-}
              -- copy rule (down)
              _aliasOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 14103 "AstInternal.hs" #-}
              -- copy rule (down)
              _aliasOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 14108 "AstInternal.hs" #-}
              ( _tblIannotatedTree,_tblIlibUpdates,_tblIoriginalTree) =
                  (tbl_ _tblOcat _tblOlib )
              ( _natIannotatedTree,_natIoriginalTree) =
                  (nat_ _natOcat _natOlib )
              ( _joinTypeIannotatedTree,_joinTypeIoriginalTree) =
                  (joinType_ _joinTypeOcat _joinTypeOlib )
              ( _tbl1IannotatedTree,_tbl1IlibUpdates,_tbl1IoriginalTree) =
                  (tbl1_ _tbl1Ocat _tbl1Olib )
              ( _onExprIannotatedTree,_onExprIoriginalTree) =
                  (onExpr_ _onExprOcat _onExprOlib )
              ( _aliasIannotatedTree,_aliasIoriginalTree) =
                  (alias_ _aliasOcat _aliasOlib )
          in  ( _lhsOannotatedTree,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_TableRef_SubTref :: Annotation ->
                        T_SelectExpression  ->
                        T_TableAlias  ->
                        T_TableRef 
sem_TableRef_SubTref ann_ sel_ alias_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: TableRef
              _selectAttrs :: (Either [TypeError] [(String,Type)])
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOoriginalTree :: TableRef
              _selOcat :: Catalog
              _selOlib :: LocalBindings
              _aliasOcat :: Catalog
              _aliasOlib :: LocalBindings
              _selIannotatedTree :: SelectExpression
              _selIlibUpdates :: ([LocalBindingsUpdate])
              _selIoriginalTree :: SelectExpression
              _aliasIannotatedTree :: TableAlias
              _aliasIoriginalTree :: TableAlias
              -- "./TypeChecking/TableRefs.ag"(line 91, column 9)
              _lhsOannotatedTree =
                  {-# LINE 91 "./TypeChecking/TableRefs.ag" #-}
                  updateAnnotation (map TypeErrorA _errs     ++) _backTree
                  {-# LINE 14146 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 135, column 9)
              _errs =
                  {-# LINE 135 "./TypeChecking/TableRefs.ag" #-}
                  case _selectAttrs     of
                          Left e -> e
                          Right _ -> []
                  {-# LINE 14153 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 139, column 9)
              _selectAttrs =
                  {-# LINE 139 "./TypeChecking/TableRefs.ag" #-}
                  unwrapSetOfComposite (getTypeAnnotation _selIannotatedTree)
                  {-# LINE 14158 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 140, column 9)
              _lhsOlibUpdates =
                  {-# LINE 140 "./TypeChecking/TableRefs.ag" #-}
                  [LBIds "sub query" (getAlias "" _aliasIannotatedTree)
                                  (fromRight [] _selectAttrs    ) []]
                  {-# LINE 14164 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 259, column 9)
              _backTree =
                  {-# LINE 259 "./TypeChecking/TableRefs.ag" #-}
                  SubTref ann_ _selIannotatedTree _aliasIannotatedTree
                  {-# LINE 14169 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  SubTref ann_ _selIannotatedTree _aliasIannotatedTree
                  {-# LINE 14174 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  SubTref ann_ _selIoriginalTree _aliasIoriginalTree
                  {-# LINE 14179 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 14184 "AstInternal.hs" #-}
              -- copy rule (down)
              _selOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 14189 "AstInternal.hs" #-}
              -- copy rule (down)
              _selOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 14194 "AstInternal.hs" #-}
              -- copy rule (down)
              _aliasOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 14199 "AstInternal.hs" #-}
              -- copy rule (down)
              _aliasOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 14204 "AstInternal.hs" #-}
              ( _selIannotatedTree,_selIlibUpdates,_selIoriginalTree) =
                  (sel_ _selOcat _selOlib )
              ( _aliasIannotatedTree,_aliasIoriginalTree) =
                  (alias_ _aliasOcat _aliasOlib )
          in  ( _lhsOannotatedTree,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_TableRef_Tref :: Annotation ->
                     String ->
                     T_TableAlias  ->
                     T_TableRef 
sem_TableRef_Tref ann_ tbl_ alias_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: TableRef
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _relType :: (Either [TypeError] ([(String, Type)], [(String, Type)]))
              _lhsOoriginalTree :: TableRef
              _aliasOcat :: Catalog
              _aliasOlib :: LocalBindings
              _aliasIannotatedTree :: TableAlias
              _aliasIoriginalTree :: TableAlias
              -- "./TypeChecking/TableRefs.ag"(line 91, column 9)
              _lhsOannotatedTree =
                  {-# LINE 91 "./TypeChecking/TableRefs.ag" #-}
                  updateAnnotation (map TypeErrorA _errs     ++) _backTree
                  {-# LINE 14229 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 148, column 9)
              _errs =
                  {-# LINE 148 "./TypeChecking/TableRefs.ag" #-}
                  case _relType     of
                    Left e -> e
                    Right _ -> []
                  {-# LINE 14236 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 151, column 9)
              _lhsOlibUpdates =
                  {-# LINE 151 "./TypeChecking/TableRefs.ag" #-}
                  [LBIds ("tref: " ++ tbl_)
                                  (getAlias tbl_ _aliasIannotatedTree)
                                  (fst _relType1    )
                                  (snd _relType1    )]
                  {-# LINE 14244 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 157, column 9)
              _relType =
                  {-# LINE 157 "./TypeChecking/TableRefs.ag" #-}
                  catCompositeAttrsPair _lhsIcat [] tbl_
                  {-# LINE 14249 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 158, column 9)
              _relType1 =
                  {-# LINE 158 "./TypeChecking/TableRefs.ag" #-}
                  fromRight ([],[]) _relType
                  {-# LINE 14254 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 261, column 9)
              _backTree =
                  {-# LINE 261 "./TypeChecking/TableRefs.ag" #-}
                  Tref ann_ tbl_ _aliasIannotatedTree
                  {-# LINE 14259 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Tref ann_ tbl_ _aliasIannotatedTree
                  {-# LINE 14264 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Tref ann_ tbl_ _aliasIoriginalTree
                  {-# LINE 14269 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 14274 "AstInternal.hs" #-}
              -- copy rule (down)
              _aliasOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 14279 "AstInternal.hs" #-}
              -- copy rule (down)
              _aliasOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 14284 "AstInternal.hs" #-}
              ( _aliasIannotatedTree,_aliasIoriginalTree) =
                  (alias_ _aliasOcat _aliasOlib )
          in  ( _lhsOannotatedTree,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_TableRef_TrefFun :: Annotation ->
                        T_Expression  ->
                        T_TableAlias  ->
                        T_TableRef 
sem_TableRef_TrefFun ann_ fn_ alias_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: TableRef
              _eqfunIdens :: (Either [TypeError] (String,[(String,Type)]))
              _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOoriginalTree :: TableRef
              _fnOcat :: Catalog
              _fnOlib :: LocalBindings
              _aliasOcat :: Catalog
              _aliasOlib :: LocalBindings
              _fnIannotatedTree :: Expression
              _fnIliftedColumnName :: String
              _fnIoriginalTree :: Expression
              _aliasIannotatedTree :: TableAlias
              _aliasIoriginalTree :: TableAlias
              -- "./TypeChecking/TableRefs.ag"(line 91, column 9)
              _lhsOannotatedTree =
                  {-# LINE 91 "./TypeChecking/TableRefs.ag" #-}
                  updateAnnotation (map TypeErrorA _errs     ++) _backTree
                  {-# LINE 14312 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 167, column 9)
              _errs =
                  {-# LINE 167 "./TypeChecking/TableRefs.ag" #-}
                  case _eqfunIdens of
                    Left e -> e
                    Right _ -> []
                  {-# LINE 14319 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 173, column 9)
              _eqfunIdens =
                  {-# LINE 173 "./TypeChecking/TableRefs.ag" #-}
                  funIdens _lhsIcat (getAlias "" _aliasIannotatedTree) _fnIannotatedTree
                  {-# LINE 14324 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 174, column 9)
              _lhsOlibUpdates =
                  {-# LINE 174 "./TypeChecking/TableRefs.ag" #-}
                  [LBIds ("fn")
                                  (fst _qfunIdens    )
                                  (snd _qfunIdens    )
                                  []]
                  {-# LINE 14332 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 178, column 9)
              _qfunIdens =
                  {-# LINE 178 "./TypeChecking/TableRefs.ag" #-}
                  fromRight ("",[]) _eqfunIdens
                  {-# LINE 14337 "AstInternal.hs" #-}
              -- "./TypeChecking/TableRefs.ag"(line 263, column 9)
              _backTree =
                  {-# LINE 263 "./TypeChecking/TableRefs.ag" #-}
                  TrefFun ann_ _fnIannotatedTree _aliasIannotatedTree
                  {-# LINE 14342 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  TrefFun ann_ _fnIannotatedTree _aliasIannotatedTree
                  {-# LINE 14347 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  TrefFun ann_ _fnIoriginalTree _aliasIoriginalTree
                  {-# LINE 14352 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 14357 "AstInternal.hs" #-}
              -- copy rule (down)
              _fnOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 14362 "AstInternal.hs" #-}
              -- copy rule (down)
              _fnOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 14367 "AstInternal.hs" #-}
              -- copy rule (down)
              _aliasOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 14372 "AstInternal.hs" #-}
              -- copy rule (down)
              _aliasOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 14377 "AstInternal.hs" #-}
              ( _fnIannotatedTree,_fnIliftedColumnName,_fnIoriginalTree) =
                  (fn_ _fnOcat _fnOlib )
              ( _aliasIannotatedTree,_aliasIoriginalTree) =
                  (alias_ _aliasOcat _aliasOlib )
          in  ( _lhsOannotatedTree,_lhsOlibUpdates,_lhsOoriginalTree)))
-- TableRefList ------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         libUpdates           : [LocalBindingsUpdate]
         originalTree         : SELF 
   alternatives:
      alternative Cons:
         child hd             : TableRef 
         child tl             : TableRefList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type TableRefList  = [(TableRef)]
-- cata
sem_TableRefList :: TableRefList  ->
                    T_TableRefList 
sem_TableRefList list  =
    (Prelude.foldr sem_TableRefList_Cons sem_TableRefList_Nil (Prelude.map sem_TableRef list) )
-- semantic domain
type T_TableRefList  = Catalog ->
                       LocalBindings ->
                       ( TableRefList,([LocalBindingsUpdate]),TableRefList)
data Inh_TableRefList  = Inh_TableRefList {cat_Inh_TableRefList :: Catalog,lib_Inh_TableRefList :: LocalBindings}
data Syn_TableRefList  = Syn_TableRefList {annotatedTree_Syn_TableRefList :: TableRefList,libUpdates_Syn_TableRefList :: [LocalBindingsUpdate],originalTree_Syn_TableRefList :: TableRefList}
wrap_TableRefList :: T_TableRefList  ->
                     Inh_TableRefList  ->
                     Syn_TableRefList 
wrap_TableRefList sem (Inh_TableRefList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOlibUpdates,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_TableRefList _lhsOannotatedTree _lhsOlibUpdates _lhsOoriginalTree ))
sem_TableRefList_Cons :: T_TableRef  ->
                         T_TableRefList  ->
                         T_TableRefList 
sem_TableRefList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: TableRefList
              _lhsOoriginalTree :: TableRefList
              _hdOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _hdIannotatedTree :: TableRef
              _hdIlibUpdates :: ([LocalBindingsUpdate])
              _hdIoriginalTree :: TableRef
              _tlIannotatedTree :: TableRefList
              _tlIlibUpdates :: ([LocalBindingsUpdate])
              _tlIoriginalTree :: TableRefList
              -- "./TypeChecking/TableRefs.ag"(line 98, column 9)
              _lhsOlibUpdates =
                  {-# LINE 98 "./TypeChecking/TableRefs.ag" #-}
                  _hdIlibUpdates
                  {-# LINE 14447 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 14452 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 14457 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 14462 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 14467 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 14472 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 14477 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 14482 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 14487 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdIlibUpdates,_hdIoriginalTree) =
                  (hd_ _hdOcat _hdOlib )
              ( _tlIannotatedTree,_tlIlibUpdates,_tlIoriginalTree) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOlibUpdates,_lhsOoriginalTree)))
sem_TableRefList_Nil :: T_TableRefList 
sem_TableRefList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOlibUpdates :: ([LocalBindingsUpdate])
              _lhsOannotatedTree :: TableRefList
              _lhsOoriginalTree :: TableRefList
              -- "./TypeChecking/TableRefs.ag"(line 96, column 9)
              _lhsOlibUpdates =
                  {-# LINE 96 "./TypeChecking/TableRefs.ag" #-}
                  []
                  {-# LINE 14504 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 14509 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 14514 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 14519 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 14524 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOlibUpdates,_lhsOoriginalTree)))
-- TriggerEvent ------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative TDelete:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative TInsert:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative TUpdate:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data TriggerEvent  = TDelete 
                   | TInsert 
                   | TUpdate 
                   deriving ( Data,Eq,Show,Typeable)
-- cata
sem_TriggerEvent :: TriggerEvent  ->
                    T_TriggerEvent 
sem_TriggerEvent (TDelete )  =
    (sem_TriggerEvent_TDelete )
sem_TriggerEvent (TInsert )  =
    (sem_TriggerEvent_TInsert )
sem_TriggerEvent (TUpdate )  =
    (sem_TriggerEvent_TUpdate )
-- semantic domain
type T_TriggerEvent  = Catalog ->
                       LocalBindings ->
                       ( TriggerEvent,TriggerEvent)
data Inh_TriggerEvent  = Inh_TriggerEvent {cat_Inh_TriggerEvent :: Catalog,lib_Inh_TriggerEvent :: LocalBindings}
data Syn_TriggerEvent  = Syn_TriggerEvent {annotatedTree_Syn_TriggerEvent :: TriggerEvent,originalTree_Syn_TriggerEvent :: TriggerEvent}
wrap_TriggerEvent :: T_TriggerEvent  ->
                     Inh_TriggerEvent  ->
                     Syn_TriggerEvent 
wrap_TriggerEvent sem (Inh_TriggerEvent _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_TriggerEvent _lhsOannotatedTree _lhsOoriginalTree ))
sem_TriggerEvent_TDelete :: T_TriggerEvent 
sem_TriggerEvent_TDelete  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: TriggerEvent
              _lhsOoriginalTree :: TriggerEvent
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  TDelete
                  {-# LINE 14585 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  TDelete
                  {-# LINE 14590 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 14595 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 14600 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_TriggerEvent_TInsert :: T_TriggerEvent 
sem_TriggerEvent_TInsert  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: TriggerEvent
              _lhsOoriginalTree :: TriggerEvent
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  TInsert
                  {-# LINE 14612 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  TInsert
                  {-# LINE 14617 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 14622 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 14627 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_TriggerEvent_TUpdate :: T_TriggerEvent 
sem_TriggerEvent_TUpdate  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: TriggerEvent
              _lhsOoriginalTree :: TriggerEvent
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  TUpdate
                  {-# LINE 14639 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  TUpdate
                  {-# LINE 14644 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 14649 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 14654 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- TriggerFire -------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative EachRow:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative EachStatement:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data TriggerFire  = EachRow 
                  | EachStatement 
                  deriving ( Data,Eq,Show,Typeable)
-- cata
sem_TriggerFire :: TriggerFire  ->
                   T_TriggerFire 
sem_TriggerFire (EachRow )  =
    (sem_TriggerFire_EachRow )
sem_TriggerFire (EachStatement )  =
    (sem_TriggerFire_EachStatement )
-- semantic domain
type T_TriggerFire  = Catalog ->
                      LocalBindings ->
                      ( TriggerFire,TriggerFire)
data Inh_TriggerFire  = Inh_TriggerFire {cat_Inh_TriggerFire :: Catalog,lib_Inh_TriggerFire :: LocalBindings}
data Syn_TriggerFire  = Syn_TriggerFire {annotatedTree_Syn_TriggerFire :: TriggerFire,originalTree_Syn_TriggerFire :: TriggerFire}
wrap_TriggerFire :: T_TriggerFire  ->
                    Inh_TriggerFire  ->
                    Syn_TriggerFire 
wrap_TriggerFire sem (Inh_TriggerFire _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_TriggerFire _lhsOannotatedTree _lhsOoriginalTree ))
sem_TriggerFire_EachRow :: T_TriggerFire 
sem_TriggerFire_EachRow  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: TriggerFire
              _lhsOoriginalTree :: TriggerFire
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  EachRow
                  {-# LINE 14708 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  EachRow
                  {-# LINE 14713 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 14718 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 14723 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_TriggerFire_EachStatement :: T_TriggerFire 
sem_TriggerFire_EachStatement  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: TriggerFire
              _lhsOoriginalTree :: TriggerFire
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  EachStatement
                  {-# LINE 14735 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  EachStatement
                  {-# LINE 14740 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 14745 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 14750 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- TriggerWhen -------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative TriggerAfter:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative TriggerBefore:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data TriggerWhen  = TriggerAfter 
                  | TriggerBefore 
                  deriving ( Data,Eq,Show,Typeable)
-- cata
sem_TriggerWhen :: TriggerWhen  ->
                   T_TriggerWhen 
sem_TriggerWhen (TriggerAfter )  =
    (sem_TriggerWhen_TriggerAfter )
sem_TriggerWhen (TriggerBefore )  =
    (sem_TriggerWhen_TriggerBefore )
-- semantic domain
type T_TriggerWhen  = Catalog ->
                      LocalBindings ->
                      ( TriggerWhen,TriggerWhen)
data Inh_TriggerWhen  = Inh_TriggerWhen {cat_Inh_TriggerWhen :: Catalog,lib_Inh_TriggerWhen :: LocalBindings}
data Syn_TriggerWhen  = Syn_TriggerWhen {annotatedTree_Syn_TriggerWhen :: TriggerWhen,originalTree_Syn_TriggerWhen :: TriggerWhen}
wrap_TriggerWhen :: T_TriggerWhen  ->
                    Inh_TriggerWhen  ->
                    Syn_TriggerWhen 
wrap_TriggerWhen sem (Inh_TriggerWhen _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_TriggerWhen _lhsOannotatedTree _lhsOoriginalTree ))
sem_TriggerWhen_TriggerAfter :: T_TriggerWhen 
sem_TriggerWhen_TriggerAfter  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: TriggerWhen
              _lhsOoriginalTree :: TriggerWhen
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  TriggerAfter
                  {-# LINE 14804 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  TriggerAfter
                  {-# LINE 14809 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 14814 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 14819 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_TriggerWhen_TriggerBefore :: T_TriggerWhen 
sem_TriggerWhen_TriggerBefore  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: TriggerWhen
              _lhsOoriginalTree :: TriggerWhen
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  TriggerBefore
                  {-# LINE 14831 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  TriggerBefore
                  {-# LINE 14836 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 14841 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 14846 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
-- TypeAttributeDef --------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         attrName             : String
         namedType            : Type
         originalTree         : SELF 
   alternatives:
      alternative TypeAttDef:
         child ann            : {Annotation}
         child name           : {String}
         child typ            : TypeName 
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data TypeAttributeDef  = TypeAttDef (Annotation) (String) (TypeName) 
                       deriving ( Data,Eq,Show,Typeable)
-- cata
sem_TypeAttributeDef :: TypeAttributeDef  ->
                        T_TypeAttributeDef 
sem_TypeAttributeDef (TypeAttDef _ann _name _typ )  =
    (sem_TypeAttributeDef_TypeAttDef _ann _name (sem_TypeName _typ ) )
-- semantic domain
type T_TypeAttributeDef  = Catalog ->
                           LocalBindings ->
                           ( TypeAttributeDef,String,Type,TypeAttributeDef)
data Inh_TypeAttributeDef  = Inh_TypeAttributeDef {cat_Inh_TypeAttributeDef :: Catalog,lib_Inh_TypeAttributeDef :: LocalBindings}
data Syn_TypeAttributeDef  = Syn_TypeAttributeDef {annotatedTree_Syn_TypeAttributeDef :: TypeAttributeDef,attrName_Syn_TypeAttributeDef :: String,namedType_Syn_TypeAttributeDef :: Type,originalTree_Syn_TypeAttributeDef :: TypeAttributeDef}
wrap_TypeAttributeDef :: T_TypeAttributeDef  ->
                         Inh_TypeAttributeDef  ->
                         Syn_TypeAttributeDef 
wrap_TypeAttributeDef sem (Inh_TypeAttributeDef _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOattrName,_lhsOnamedType,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_TypeAttributeDef _lhsOannotatedTree _lhsOattrName _lhsOnamedType _lhsOoriginalTree ))
sem_TypeAttributeDef_TypeAttDef :: Annotation ->
                                   String ->
                                   T_TypeName  ->
                                   T_TypeAttributeDef 
sem_TypeAttributeDef_TypeAttDef ann_ name_ typ_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOattrName :: String
              _lhsOnamedType :: Type
              _lhsOannotatedTree :: TypeAttributeDef
              _lhsOoriginalTree :: TypeAttributeDef
              _typOcat :: Catalog
              _typOlib :: LocalBindings
              _typIannotatedTree :: TypeName
              _typInamedType :: Type
              _typIoriginalTree :: TypeName
              -- "./TypeChecking/MiscCreates.ag"(line 40, column 9)
              _lhsOattrName =
                  {-# LINE 40 "./TypeChecking/MiscCreates.ag" #-}
                  name_
                  {-# LINE 14908 "AstInternal.hs" #-}
              -- "./TypeChecking/MiscCreates.ag"(line 41, column 9)
              _lhsOnamedType =
                  {-# LINE 41 "./TypeChecking/MiscCreates.ag" #-}
                  _typInamedType
                  {-# LINE 14913 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  TypeAttDef ann_ name_ _typIannotatedTree
                  {-# LINE 14918 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  TypeAttDef ann_ name_ _typIoriginalTree
                  {-# LINE 14923 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 14928 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 14933 "AstInternal.hs" #-}
              -- copy rule (down)
              _typOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 14938 "AstInternal.hs" #-}
              -- copy rule (down)
              _typOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 14943 "AstInternal.hs" #-}
              ( _typIannotatedTree,_typInamedType,_typIoriginalTree) =
                  (typ_ _typOcat _typOlib )
          in  ( _lhsOannotatedTree,_lhsOattrName,_lhsOnamedType,_lhsOoriginalTree)))
-- TypeAttributeDefList ----------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         attrs                : [(String, Type)]
         originalTree         : SELF 
   alternatives:
      alternative Cons:
         child hd             : TypeAttributeDef 
         child tl             : TypeAttributeDefList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type TypeAttributeDefList  = [(TypeAttributeDef)]
-- cata
sem_TypeAttributeDefList :: TypeAttributeDefList  ->
                            T_TypeAttributeDefList 
sem_TypeAttributeDefList list  =
    (Prelude.foldr sem_TypeAttributeDefList_Cons sem_TypeAttributeDefList_Nil (Prelude.map sem_TypeAttributeDef list) )
-- semantic domain
type T_TypeAttributeDefList  = Catalog ->
                               LocalBindings ->
                               ( TypeAttributeDefList,([(String, Type)]),TypeAttributeDefList)
data Inh_TypeAttributeDefList  = Inh_TypeAttributeDefList {cat_Inh_TypeAttributeDefList :: Catalog,lib_Inh_TypeAttributeDefList :: LocalBindings}
data Syn_TypeAttributeDefList  = Syn_TypeAttributeDefList {annotatedTree_Syn_TypeAttributeDefList :: TypeAttributeDefList,attrs_Syn_TypeAttributeDefList :: [(String, Type)],originalTree_Syn_TypeAttributeDefList :: TypeAttributeDefList}
wrap_TypeAttributeDefList :: T_TypeAttributeDefList  ->
                             Inh_TypeAttributeDefList  ->
                             Syn_TypeAttributeDefList 
wrap_TypeAttributeDefList sem (Inh_TypeAttributeDefList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOattrs,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_TypeAttributeDefList _lhsOannotatedTree _lhsOattrs _lhsOoriginalTree ))
sem_TypeAttributeDefList_Cons :: T_TypeAttributeDef  ->
                                 T_TypeAttributeDefList  ->
                                 T_TypeAttributeDefList 
sem_TypeAttributeDefList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOattrs :: ([(String, Type)])
              _lhsOannotatedTree :: TypeAttributeDefList
              _lhsOoriginalTree :: TypeAttributeDefList
              _hdOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _hdIannotatedTree :: TypeAttributeDef
              _hdIattrName :: String
              _hdInamedType :: Type
              _hdIoriginalTree :: TypeAttributeDef
              _tlIannotatedTree :: TypeAttributeDefList
              _tlIattrs :: ([(String, Type)])
              _tlIoriginalTree :: TypeAttributeDefList
              -- "./TypeChecking/MiscCreates.ag"(line 46, column 12)
              _lhsOattrs =
                  {-# LINE 46 "./TypeChecking/MiscCreates.ag" #-}
                  (_hdIattrName, _hdInamedType) : _tlIattrs
                  {-# LINE 15012 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 15017 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 15022 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 15027 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 15032 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 15037 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 15042 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 15047 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 15052 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdIattrName,_hdInamedType,_hdIoriginalTree) =
                  (hd_ _hdOcat _hdOlib )
              ( _tlIannotatedTree,_tlIattrs,_tlIoriginalTree) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOattrs,_lhsOoriginalTree)))
sem_TypeAttributeDefList_Nil :: T_TypeAttributeDefList 
sem_TypeAttributeDefList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOattrs :: ([(String, Type)])
              _lhsOannotatedTree :: TypeAttributeDefList
              _lhsOoriginalTree :: TypeAttributeDefList
              -- "./TypeChecking/MiscCreates.ag"(line 47, column 11)
              _lhsOattrs =
                  {-# LINE 47 "./TypeChecking/MiscCreates.ag" #-}
                  []
                  {-# LINE 15069 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 15074 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 15079 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 15084 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 15089 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOattrs,_lhsOoriginalTree)))
-- TypeName ----------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         namedType            : Type
         originalTree         : SELF 
   alternatives:
      alternative ArrayTypeName:
         child ann            : {Annotation}
         child typ            : TypeName 
         visit 0:
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative PrecTypeName:
         child ann            : {Annotation}
         child tn             : {String}
         child prec           : {Integer}
         visit 0:
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative SetOfTypeName:
         child ann            : {Annotation}
         child typ            : TypeName 
         visit 0:
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
      alternative SimpleTypeName:
         child ann            : {Annotation}
         child tn             : {String}
         visit 0:
            local tpe         : _
            local backTree    : _
            local annotatedTree : _
            local originalTree : _
-}
data TypeName  = ArrayTypeName (Annotation) (TypeName) 
               | PrecTypeName (Annotation) (String) (Integer) 
               | SetOfTypeName (Annotation) (TypeName) 
               | SimpleTypeName (Annotation) (String) 
               deriving ( Data,Eq,Show,Typeable)
-- cata
sem_TypeName :: TypeName  ->
                T_TypeName 
sem_TypeName (ArrayTypeName _ann _typ )  =
    (sem_TypeName_ArrayTypeName _ann (sem_TypeName _typ ) )
sem_TypeName (PrecTypeName _ann _tn _prec )  =
    (sem_TypeName_PrecTypeName _ann _tn _prec )
sem_TypeName (SetOfTypeName _ann _typ )  =
    (sem_TypeName_SetOfTypeName _ann (sem_TypeName _typ ) )
sem_TypeName (SimpleTypeName _ann _tn )  =
    (sem_TypeName_SimpleTypeName _ann _tn )
-- semantic domain
type T_TypeName  = Catalog ->
                   LocalBindings ->
                   ( TypeName,Type,TypeName)
data Inh_TypeName  = Inh_TypeName {cat_Inh_TypeName :: Catalog,lib_Inh_TypeName :: LocalBindings}
data Syn_TypeName  = Syn_TypeName {annotatedTree_Syn_TypeName :: TypeName,namedType_Syn_TypeName :: Type,originalTree_Syn_TypeName :: TypeName}
wrap_TypeName :: T_TypeName  ->
                 Inh_TypeName  ->
                 Syn_TypeName 
wrap_TypeName sem (Inh_TypeName _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOnamedType,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_TypeName _lhsOannotatedTree _lhsOnamedType _lhsOoriginalTree ))
sem_TypeName_ArrayTypeName :: Annotation ->
                              T_TypeName  ->
                              T_TypeName 
sem_TypeName_ArrayTypeName ann_ typ_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOnamedType :: Type
              _lhsOannotatedTree :: TypeName
              _lhsOoriginalTree :: TypeName
              _typOcat :: Catalog
              _typOlib :: LocalBindings
              _typIannotatedTree :: TypeName
              _typInamedType :: Type
              _typIoriginalTree :: TypeName
              -- "./TypeChecking/Misc.ag"(line 19, column 10)
              _lhsOnamedType =
                  {-# LINE 19 "./TypeChecking/Misc.ag" #-}
                  tpeToT _tpe
                  {-# LINE 15183 "AstInternal.hs" #-}
              -- "./TypeChecking/Misc.ag"(line 20, column 10)
              _lhsOannotatedTree =
                  {-# LINE 20 "./TypeChecking/Misc.ag" #-}
                  updateAnnotation
                    ((map TypeErrorA $ getErrors _tpe    ) ++)
                    _backTree
                  {-# LINE 15190 "AstInternal.hs" #-}
              -- "./TypeChecking/Misc.ag"(line 30, column 9)
              _tpe =
                  {-# LINE 30 "./TypeChecking/Misc.ag" #-}
                  dependsOnRTpe [_typInamedType] $ Right $ ArrayType _typInamedType
                  {-# LINE 15195 "AstInternal.hs" #-}
              -- "./TypeChecking/Misc.ag"(line 31, column 9)
              _backTree =
                  {-# LINE 31 "./TypeChecking/Misc.ag" #-}
                  ArrayTypeName ann_ _typIannotatedTree
                  {-# LINE 15200 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  ArrayTypeName ann_ _typIannotatedTree
                  {-# LINE 15205 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  ArrayTypeName ann_ _typIoriginalTree
                  {-# LINE 15210 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 15215 "AstInternal.hs" #-}
              -- copy rule (down)
              _typOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 15220 "AstInternal.hs" #-}
              -- copy rule (down)
              _typOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 15225 "AstInternal.hs" #-}
              ( _typIannotatedTree,_typInamedType,_typIoriginalTree) =
                  (typ_ _typOcat _typOlib )
          in  ( _lhsOannotatedTree,_lhsOnamedType,_lhsOoriginalTree)))
sem_TypeName_PrecTypeName :: Annotation ->
                             String ->
                             Integer ->
                             T_TypeName 
sem_TypeName_PrecTypeName ann_ tn_ prec_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOnamedType :: Type
              _lhsOannotatedTree :: TypeName
              _lhsOoriginalTree :: TypeName
              -- "./TypeChecking/Misc.ag"(line 19, column 10)
              _lhsOnamedType =
                  {-# LINE 19 "./TypeChecking/Misc.ag" #-}
                  tpeToT _tpe
                  {-# LINE 15243 "AstInternal.hs" #-}
              -- "./TypeChecking/Misc.ag"(line 20, column 10)
              _lhsOannotatedTree =
                  {-# LINE 20 "./TypeChecking/Misc.ag" #-}
                  updateAnnotation
                    ((map TypeErrorA $ getErrors _tpe    ) ++)
                    _backTree
                  {-# LINE 15250 "AstInternal.hs" #-}
              -- "./TypeChecking/Misc.ag"(line 36, column 9)
              _tpe =
                  {-# LINE 36 "./TypeChecking/Misc.ag" #-}
                  catLookupType _lhsIcat $ canonicalizeTypeName tn_
                  {-# LINE 15255 "AstInternal.hs" #-}
              -- "./TypeChecking/Misc.ag"(line 37, column 9)
              _backTree =
                  {-# LINE 37 "./TypeChecking/Misc.ag" #-}
                  PrecTypeName ann_ tn_ prec_
                  {-# LINE 15260 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  PrecTypeName ann_ tn_ prec_
                  {-# LINE 15265 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  PrecTypeName ann_ tn_ prec_
                  {-# LINE 15270 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 15275 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOnamedType,_lhsOoriginalTree)))
sem_TypeName_SetOfTypeName :: Annotation ->
                              T_TypeName  ->
                              T_TypeName 
sem_TypeName_SetOfTypeName ann_ typ_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOnamedType :: Type
              _lhsOannotatedTree :: TypeName
              _lhsOoriginalTree :: TypeName
              _typOcat :: Catalog
              _typOlib :: LocalBindings
              _typIannotatedTree :: TypeName
              _typInamedType :: Type
              _typIoriginalTree :: TypeName
              -- "./TypeChecking/Misc.ag"(line 19, column 10)
              _lhsOnamedType =
                  {-# LINE 19 "./TypeChecking/Misc.ag" #-}
                  tpeToT _tpe
                  {-# LINE 15295 "AstInternal.hs" #-}
              -- "./TypeChecking/Misc.ag"(line 20, column 10)
              _lhsOannotatedTree =
                  {-# LINE 20 "./TypeChecking/Misc.ag" #-}
                  updateAnnotation
                    ((map TypeErrorA $ getErrors _tpe    ) ++)
                    _backTree
                  {-# LINE 15302 "AstInternal.hs" #-}
              -- "./TypeChecking/Misc.ag"(line 33, column 9)
              _tpe =
                  {-# LINE 33 "./TypeChecking/Misc.ag" #-}
                  dependsOnRTpe [_typInamedType] $ Right $ SetOfType _typInamedType
                  {-# LINE 15307 "AstInternal.hs" #-}
              -- "./TypeChecking/Misc.ag"(line 34, column 9)
              _backTree =
                  {-# LINE 34 "./TypeChecking/Misc.ag" #-}
                  SetOfTypeName ann_ _typIannotatedTree
                  {-# LINE 15312 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  SetOfTypeName ann_ _typIannotatedTree
                  {-# LINE 15317 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  SetOfTypeName ann_ _typIoriginalTree
                  {-# LINE 15322 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 15327 "AstInternal.hs" #-}
              -- copy rule (down)
              _typOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 15332 "AstInternal.hs" #-}
              -- copy rule (down)
              _typOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 15337 "AstInternal.hs" #-}
              ( _typIannotatedTree,_typInamedType,_typIoriginalTree) =
                  (typ_ _typOcat _typOlib )
          in  ( _lhsOannotatedTree,_lhsOnamedType,_lhsOoriginalTree)))
sem_TypeName_SimpleTypeName :: Annotation ->
                               String ->
                               T_TypeName 
sem_TypeName_SimpleTypeName ann_ tn_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOnamedType :: Type
              _lhsOannotatedTree :: TypeName
              _lhsOoriginalTree :: TypeName
              -- "./TypeChecking/Misc.ag"(line 19, column 10)
              _lhsOnamedType =
                  {-# LINE 19 "./TypeChecking/Misc.ag" #-}
                  tpeToT _tpe
                  {-# LINE 15354 "AstInternal.hs" #-}
              -- "./TypeChecking/Misc.ag"(line 20, column 10)
              _lhsOannotatedTree =
                  {-# LINE 20 "./TypeChecking/Misc.ag" #-}
                  updateAnnotation
                    ((map TypeErrorA $ getErrors _tpe    ) ++)
                    _backTree
                  {-# LINE 15361 "AstInternal.hs" #-}
              -- "./TypeChecking/Misc.ag"(line 27, column 9)
              _tpe =
                  {-# LINE 27 "./TypeChecking/Misc.ag" #-}
                  catLookupType _lhsIcat $ canonicalizeTypeName tn_
                  {-# LINE 15366 "AstInternal.hs" #-}
              -- "./TypeChecking/Misc.ag"(line 28, column 9)
              _backTree =
                  {-# LINE 28 "./TypeChecking/Misc.ag" #-}
                  SimpleTypeName ann_ tn_
                  {-# LINE 15371 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  SimpleTypeName ann_ tn_
                  {-# LINE 15376 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  SimpleTypeName ann_ tn_
                  {-# LINE 15381 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 15386 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOnamedType,_lhsOoriginalTree)))
-- TypeNameList ------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         namedTypes           : [Type]
         originalTree         : SELF 
   alternatives:
      alternative Cons:
         child hd             : TypeName 
         child tl             : TypeNameList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type TypeNameList  = [(TypeName)]
-- cata
sem_TypeNameList :: TypeNameList  ->
                    T_TypeNameList 
sem_TypeNameList list  =
    (Prelude.foldr sem_TypeNameList_Cons sem_TypeNameList_Nil (Prelude.map sem_TypeName list) )
-- semantic domain
type T_TypeNameList  = Catalog ->
                       LocalBindings ->
                       ( TypeNameList,([Type]),TypeNameList)
data Inh_TypeNameList  = Inh_TypeNameList {cat_Inh_TypeNameList :: Catalog,lib_Inh_TypeNameList :: LocalBindings}
data Syn_TypeNameList  = Syn_TypeNameList {annotatedTree_Syn_TypeNameList :: TypeNameList,namedTypes_Syn_TypeNameList :: [Type],originalTree_Syn_TypeNameList :: TypeNameList}
wrap_TypeNameList :: T_TypeNameList  ->
                     Inh_TypeNameList  ->
                     Syn_TypeNameList 
wrap_TypeNameList sem (Inh_TypeNameList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOnamedTypes,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_TypeNameList _lhsOannotatedTree _lhsOnamedTypes _lhsOoriginalTree ))
sem_TypeNameList_Cons :: T_TypeName  ->
                         T_TypeNameList  ->
                         T_TypeNameList 
sem_TypeNameList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOnamedTypes :: ([Type])
              _lhsOannotatedTree :: TypeNameList
              _lhsOoriginalTree :: TypeNameList
              _hdOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _hdIannotatedTree :: TypeName
              _hdInamedType :: Type
              _hdIoriginalTree :: TypeName
              _tlIannotatedTree :: TypeNameList
              _tlInamedTypes :: ([Type])
              _tlIoriginalTree :: TypeNameList
              -- "./TypeChecking/Drops.ag"(line 30, column 12)
              _lhsOnamedTypes =
                  {-# LINE 30 "./TypeChecking/Drops.ag" #-}
                  _hdInamedType : _tlInamedTypes
                  {-# LINE 15452 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 15457 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 15462 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 15467 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 15472 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 15477 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 15482 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 15487 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 15492 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdInamedType,_hdIoriginalTree) =
                  (hd_ _hdOcat _hdOlib )
              ( _tlIannotatedTree,_tlInamedTypes,_tlIoriginalTree) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOnamedTypes,_lhsOoriginalTree)))
sem_TypeNameList_Nil :: T_TypeNameList 
sem_TypeNameList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOnamedTypes :: ([Type])
              _lhsOannotatedTree :: TypeNameList
              _lhsOoriginalTree :: TypeNameList
              -- "./TypeChecking/Drops.ag"(line 31, column 11)
              _lhsOnamedTypes =
                  {-# LINE 31 "./TypeChecking/Drops.ag" #-}
                  []
                  {-# LINE 15509 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 15514 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 15519 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 15524 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 15529 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOnamedTypes,_lhsOoriginalTree)))
-- VarDef ------------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         def                  : (String,Type)
         originalTree         : SELF 
   alternatives:
      alternative VarDef:
         child ann            : {Annotation}
         child name           : {String}
         child typ            : TypeName 
         child value          : {Maybe Expression}
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data VarDef  = VarDef (Annotation) (String) (TypeName) (Maybe Expression) 
             deriving ( Data,Eq,Show,Typeable)
-- cata
sem_VarDef :: VarDef  ->
              T_VarDef 
sem_VarDef (VarDef _ann _name _typ _value )  =
    (sem_VarDef_VarDef _ann _name (sem_TypeName _typ ) _value )
-- semantic domain
type T_VarDef  = Catalog ->
                 LocalBindings ->
                 ( VarDef,((String,Type)),VarDef)
data Inh_VarDef  = Inh_VarDef {cat_Inh_VarDef :: Catalog,lib_Inh_VarDef :: LocalBindings}
data Syn_VarDef  = Syn_VarDef {annotatedTree_Syn_VarDef :: VarDef,def_Syn_VarDef :: (String,Type),originalTree_Syn_VarDef :: VarDef}
wrap_VarDef :: T_VarDef  ->
               Inh_VarDef  ->
               Syn_VarDef 
wrap_VarDef sem (Inh_VarDef _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOdef,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_VarDef _lhsOannotatedTree _lhsOdef _lhsOoriginalTree ))
sem_VarDef_VarDef :: Annotation ->
                     String ->
                     T_TypeName  ->
                     (Maybe Expression) ->
                     T_VarDef 
sem_VarDef_VarDef ann_ name_ typ_ value_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOdef :: ((String,Type))
              _lhsOannotatedTree :: VarDef
              _lhsOoriginalTree :: VarDef
              _typOcat :: Catalog
              _typOlib :: LocalBindings
              _typIannotatedTree :: TypeName
              _typInamedType :: Type
              _typIoriginalTree :: TypeName
              -- "./TypeChecking/CreateFunction.ag"(line 130, column 14)
              _lhsOdef =
                  {-# LINE 130 "./TypeChecking/CreateFunction.ag" #-}
                  (name_, if _typInamedType == Pseudo Record then PgRecord Nothing else _typInamedType)
                  {-# LINE 15591 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  VarDef ann_ name_ _typIannotatedTree value_
                  {-# LINE 15596 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  VarDef ann_ name_ _typIoriginalTree value_
                  {-# LINE 15601 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 15606 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 15611 "AstInternal.hs" #-}
              -- copy rule (down)
              _typOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 15616 "AstInternal.hs" #-}
              -- copy rule (down)
              _typOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 15621 "AstInternal.hs" #-}
              ( _typIannotatedTree,_typInamedType,_typIoriginalTree) =
                  (typ_ _typOcat _typOlib )
          in  ( _lhsOannotatedTree,_lhsOdef,_lhsOoriginalTree)))
-- VarDefList --------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         defs                 : [(String,Type)]
         originalTree         : SELF 
   alternatives:
      alternative Cons:
         child hd             : VarDef 
         child tl             : VarDefList 
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Nil:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
type VarDefList  = [(VarDef)]
-- cata
sem_VarDefList :: VarDefList  ->
                  T_VarDefList 
sem_VarDefList list  =
    (Prelude.foldr sem_VarDefList_Cons sem_VarDefList_Nil (Prelude.map sem_VarDef list) )
-- semantic domain
type T_VarDefList  = Catalog ->
                     LocalBindings ->
                     ( VarDefList,([(String,Type)]),VarDefList)
data Inh_VarDefList  = Inh_VarDefList {cat_Inh_VarDefList :: Catalog,lib_Inh_VarDefList :: LocalBindings}
data Syn_VarDefList  = Syn_VarDefList {annotatedTree_Syn_VarDefList :: VarDefList,defs_Syn_VarDefList :: [(String,Type)],originalTree_Syn_VarDefList :: VarDefList}
wrap_VarDefList :: T_VarDefList  ->
                   Inh_VarDefList  ->
                   Syn_VarDefList 
wrap_VarDefList sem (Inh_VarDefList _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOdefs,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_VarDefList _lhsOannotatedTree _lhsOdefs _lhsOoriginalTree ))
sem_VarDefList_Cons :: T_VarDef  ->
                       T_VarDefList  ->
                       T_VarDefList 
sem_VarDefList_Cons hd_ tl_  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOdefs :: ([(String,Type)])
              _lhsOannotatedTree :: VarDefList
              _lhsOoriginalTree :: VarDefList
              _hdOcat :: Catalog
              _hdOlib :: LocalBindings
              _tlOcat :: Catalog
              _tlOlib :: LocalBindings
              _hdIannotatedTree :: VarDef
              _hdIdef :: ((String,Type))
              _hdIoriginalTree :: VarDef
              _tlIannotatedTree :: VarDefList
              _tlIdefs :: ([(String,Type)])
              _tlIoriginalTree :: VarDefList
              -- "./TypeChecking/CreateFunction.ag"(line 133, column 12)
              _lhsOdefs =
                  {-# LINE 133 "./TypeChecking/CreateFunction.ag" #-}
                  _hdIdef : _tlIdefs
                  {-# LINE 15689 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIannotatedTree _tlIannotatedTree
                  {-# LINE 15694 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  (:) _hdIoriginalTree _tlIoriginalTree
                  {-# LINE 15699 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 15704 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 15709 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 15714 "AstInternal.hs" #-}
              -- copy rule (down)
              _hdOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 15719 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOcat =
                  {-# LINE 56 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIcat
                  {-# LINE 15724 "AstInternal.hs" #-}
              -- copy rule (down)
              _tlOlib =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _lhsIlib
                  {-# LINE 15729 "AstInternal.hs" #-}
              ( _hdIannotatedTree,_hdIdef,_hdIoriginalTree) =
                  (hd_ _hdOcat _hdOlib )
              ( _tlIannotatedTree,_tlIdefs,_tlIoriginalTree) =
                  (tl_ _tlOcat _tlOlib )
          in  ( _lhsOannotatedTree,_lhsOdefs,_lhsOoriginalTree)))
sem_VarDefList_Nil :: T_VarDefList 
sem_VarDefList_Nil  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOdefs :: ([(String,Type)])
              _lhsOannotatedTree :: VarDefList
              _lhsOoriginalTree :: VarDefList
              -- "./TypeChecking/CreateFunction.ag"(line 134, column 11)
              _lhsOdefs =
                  {-# LINE 134 "./TypeChecking/CreateFunction.ag" #-}
                  []
                  {-# LINE 15746 "AstInternal.hs" #-}
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 15751 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  []
                  {-# LINE 15756 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 15761 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 15766 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOdefs,_lhsOoriginalTree)))
-- Volatility --------------------------------------------------
{-
   visit 0:
      inherited attributes:
         cat                  : Catalog
         lib                  : LocalBindings
      synthesized attributes:
         annotatedTree        : SELF 
         originalTree         : SELF 
   alternatives:
      alternative Immutable:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Stable:
         visit 0:
            local annotatedTree : _
            local originalTree : _
      alternative Volatile:
         visit 0:
            local annotatedTree : _
            local originalTree : _
-}
data Volatility  = Immutable 
                 | Stable 
                 | Volatile 
                 deriving ( Data,Eq,Show,Typeable)
-- cata
sem_Volatility :: Volatility  ->
                  T_Volatility 
sem_Volatility (Immutable )  =
    (sem_Volatility_Immutable )
sem_Volatility (Stable )  =
    (sem_Volatility_Stable )
sem_Volatility (Volatile )  =
    (sem_Volatility_Volatile )
-- semantic domain
type T_Volatility  = Catalog ->
                     LocalBindings ->
                     ( Volatility,Volatility)
data Inh_Volatility  = Inh_Volatility {cat_Inh_Volatility :: Catalog,lib_Inh_Volatility :: LocalBindings}
data Syn_Volatility  = Syn_Volatility {annotatedTree_Syn_Volatility :: Volatility,originalTree_Syn_Volatility :: Volatility}
wrap_Volatility :: T_Volatility  ->
                   Inh_Volatility  ->
                   Syn_Volatility 
wrap_Volatility sem (Inh_Volatility _lhsIcat _lhsIlib )  =
    (let ( _lhsOannotatedTree,_lhsOoriginalTree) =
             (sem _lhsIcat _lhsIlib )
     in  (Syn_Volatility _lhsOannotatedTree _lhsOoriginalTree ))
sem_Volatility_Immutable :: T_Volatility 
sem_Volatility_Immutable  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Volatility
              _lhsOoriginalTree :: Volatility
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Immutable
                  {-# LINE 15827 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Immutable
                  {-# LINE 15832 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 15837 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 15842 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_Volatility_Stable :: T_Volatility 
sem_Volatility_Stable  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Volatility
              _lhsOoriginalTree :: Volatility
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Stable
                  {-# LINE 15854 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Stable
                  {-# LINE 15859 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 15864 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 15869 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))
sem_Volatility_Volatile :: T_Volatility 
sem_Volatility_Volatile  =
    (\ _lhsIcat
       _lhsIlib ->
         (let _lhsOannotatedTree :: Volatility
              _lhsOoriginalTree :: Volatility
              -- self rule
              _annotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  Volatile
                  {-# LINE 15881 "AstInternal.hs" #-}
              -- self rule
              _originalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  Volatile
                  {-# LINE 15886 "AstInternal.hs" #-}
              -- self rule
              _lhsOannotatedTree =
                  {-# LINE 57 "./TypeChecking/TypeChecking.ag" #-}
                  _annotatedTree
                  {-# LINE 15891 "AstInternal.hs" #-}
              -- self rule
              _lhsOoriginalTree =
                  {-# LINE 63 "./TypeChecking/TypeChecking.ag" #-}
                  _originalTree
                  {-# LINE 15896 "AstInternal.hs" #-}
          in  ( _lhsOannotatedTree,_lhsOoriginalTree)))