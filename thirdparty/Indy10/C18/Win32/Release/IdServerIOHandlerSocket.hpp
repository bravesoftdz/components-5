// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'IdServerIOHandlerSocket.pas' rev: 25.00 (Windows)

#ifndef IdserveriohandlersocketHPP
#define IdserveriohandlersocketHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <IdSocketHandle.hpp>	// Pascal unit
#include <IdGlobal.hpp>	// Pascal unit
#include <IdThread.hpp>	// Pascal unit
#include <IdServerIOHandler.hpp>	// Pascal unit
#include <IdStackConsts.hpp>	// Pascal unit
#include <IdIOHandler.hpp>	// Pascal unit
#include <IdScheduler.hpp>	// Pascal unit
#include <IdIOHandlerSocket.hpp>	// Pascal unit
#include <IdYarn.hpp>	// Pascal unit
#include <IdComponent.hpp>	// Pascal unit
#include <IdBaseComponent.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Idserveriohandlersocket
{
//-- type declarations -------------------------------------------------------
typedef System::TMetaClass* TIdIOHandlerSocketClass;

class DELPHICLASS TIdServerIOHandlerSocket;
class PASCALIMPLEMENTATION TIdServerIOHandlerSocket : public Idserveriohandler::TIdServerIOHandler
{
	typedef Idserveriohandler::TIdServerIOHandler inherited;
	
protected:
	TIdIOHandlerSocketClass IOHandlerSocketClass;
	virtual void __fastcall InitComponent(void);
	
public:
	virtual Idiohandler::TIdIOHandler* __fastcall Accept(Idsockethandle::TIdSocketHandle* ASocket, Idthread::TIdThread* AListenerThread, Idyarn::TIdYarn* AYarn);
	virtual void __fastcall Init(void);
public:
	/* TIdComponent.Destroy */ inline __fastcall virtual ~TIdServerIOHandlerSocket(void) { }
	
public:
	/* TIdBaseComponent.Create */ inline __fastcall TIdServerIOHandlerSocket(System::Classes::TComponent* AOwner)/* overload */ : Idserveriohandler::TIdServerIOHandler(AOwner) { }
	
public:
	/* TIdInitializerComponent.Create */ inline __fastcall TIdServerIOHandlerSocket(void)/* overload */ : Idserveriohandler::TIdServerIOHandler() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Idserveriohandlersocket */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_IDSERVERIOHANDLERSOCKET)
using namespace Idserveriohandlersocket;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// IdserveriohandlersocketHPP
