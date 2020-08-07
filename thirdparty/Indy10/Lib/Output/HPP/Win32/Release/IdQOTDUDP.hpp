// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'IdQOTDUDP.pas' rev: 25.00 (Windows)

#ifndef IdqotdudpHPP
#define IdqotdudpHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <IdAssignedNumbers.hpp>	// Pascal unit
#include <IdUDPBase.hpp>	// Pascal unit
#include <IdUDPClient.hpp>	// Pascal unit
#include <IdComponent.hpp>	// Pascal unit
#include <IdBaseComponent.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Idqotdudp
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TIdQOTDUDP;
class PASCALIMPLEMENTATION TIdQOTDUDP : public Idudpclient::TIdUDPClient
{
	typedef Idudpclient::TIdUDPClient inherited;
	
protected:
	System::UnicodeString __fastcall GetQuote(void);
	virtual void __fastcall InitComponent(void);
	
public:
	__property System::UnicodeString Quote = {read=GetQuote};
	
__published:
	__property Port = {default=17};
public:
	/* TIdUDPClient.Destroy */ inline __fastcall virtual ~TIdQOTDUDP(void) { }
	
public:
	/* TIdBaseComponent.Create */ inline __fastcall TIdQOTDUDP(System::Classes::TComponent* AOwner)/* overload */ : Idudpclient::TIdUDPClient(AOwner) { }
	
public:
	/* TIdInitializerComponent.Create */ inline __fastcall TIdQOTDUDP(void)/* overload */ : Idudpclient::TIdUDPClient() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Idqotdudp */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_IDQOTDUDP)
using namespace Idqotdudp;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// IdqotdudpHPP
