Drop View OKS_ContasReceberRecebidas;
Create View OKS_ContasReceberRecebidas
as
Select
	J0."Number",
	J1."TransId",
	J1."Line_ID",
	T0."CardCode",
	T0."CardName",
	J1."SourceLine",
	C0."ReconDate",
	J0."DueDate",
	C0."ReconType",
	Case C0."ReconType" 
		When '0' Then 'Manual'
		When '3' Then 'CR/CP'
		When '4' Then 'Devolvido'
		When '5' Then 'Estornado'
		When '7' Then 'Cancelado'
		When '13' Then 'Despesa de Alocação'
		When '16' Then 'Adto'
	End as "ReconTypeDescription",
	C1."ReconSum",
	J1."TransType",
	J1."BaseRef"
From
	OITR C0
	Inner Join ITR1 C1 On C0."ReconNum" = C1."ReconNum"
	Inner Join JDT1 J1
		Inner Join OJDT J0 On J1."TransId" = J0."TransId"
	On J1."TransId" = C1."TransId" And J1."Line_ID" = C1."TransRowId"
	Inner Join OCRD T0 On T0."CardCode" = J1."ShortName" And T0."CardType" = 'C'
Where
	J1."Debit" > 0
	And C0."ReconType" in ('0', '3', '16') 
	--And J0."TransId" = '4850'

