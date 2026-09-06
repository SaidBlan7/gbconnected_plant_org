package com.gbc.access.functions;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gbc.access.model.*;
import com.gbc.access.security.CallerIdentityResolver;
import com.gbc.access.service.LakebaseDataApiException;
import com.gbc.access.service.PlantCrudService;
import com.microsoft.azure.functions.*;
import com.microsoft.azure.functions.annotation.*;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.Optional;

@Component
public class PlantsCrudFunction {
    private final PlantCrudService service;
    private final CallerIdentityResolver identityResolver;
    private final ObjectMapper mapper = new ObjectMapper();

    public PlantsCrudFunction(PlantCrudService service, CallerIdentityResolver identityResolver){this.service=service;this.identityResolver=identityResolver;}

    @FunctionName("plantsCrudCollection")
    public HttpResponseMessage collection(
            @HttpTrigger(name="request", methods={HttpMethod.GET,HttpMethod.POST}, authLevel=AuthorizationLevel.ANONYMOUS, route="plants")
            HttpRequestMessage<Optional<String>> request,
            ExecutionContext context) {
        try {
            if(request.getHttpMethod()==HttpMethod.GET){
                Long orgId=parseLongNullable(request.getQueryParameters().get("organizationId"),"organizationId");
                Boolean active=parseBoolean(request.getQueryParameters().get("active"));
                return json(request,HttpStatus.OK,service.list(orgId,active));
            }
            CallerIdentity caller=identityResolver.resolve(request);
            PlantCreateRequest body=mapper.readValue(request.getBody().orElseThrow(() -> new IllegalArgumentException("JSON body is required")),PlantCreateRequest.class);
            return json(request,HttpStatus.CREATED,service.create(body,audit(caller)));
        } catch (SecurityException ex) { return json(request,HttpStatus.UNAUTHORIZED,Map.of("error","Unauthorized"));
        } catch (IllegalArgumentException ex) { return json(request,HttpStatus.BAD_REQUEST,Map.of("error",ex.getMessage()));
        } catch (LakebaseDataApiException ex) { return upstream(request,ex);
        } catch (Exception ex) { context.getLogger().severe("Plants collection error: "+ex.getMessage()); return json(request,HttpStatus.INTERNAL_SERVER_ERROR,Map.of("error","Unable to process plants")); }
    }

    @FunctionName("plantsCrudById")
    public HttpResponseMessage byId(
            @HttpTrigger(name="request", methods={HttpMethod.GET,HttpMethod.PATCH,HttpMethod.PUT,HttpMethod.DELETE}, authLevel=AuthorizationLevel.ANONYMOUS, route="plants/{plantId}")
            HttpRequestMessage<Optional<String>> request,
            @BindingName("plantId") String plantId,
            ExecutionContext context) {
        try {
            long id=parseLong(plantId,"plantId");
            if(request.getHttpMethod()==HttpMethod.GET) return service.get(id).map(p->json(request,HttpStatus.OK,p)).orElseGet(()->json(request,HttpStatus.NOT_FOUND,Map.of("error","Plant not found")));
            CallerIdentity caller=identityResolver.resolve(request);
            if(request.getHttpMethod()==HttpMethod.DELETE) return service.delete(id)?request.createResponseBuilder(HttpStatus.NO_CONTENT).build():json(request,HttpStatus.NOT_FOUND,Map.of("error","Plant not found"));
            String raw=request.getBody().orElseThrow(() -> new IllegalArgumentException("JSON body is required"));
            if(request.getHttpMethod()==HttpMethod.PUT){
                PlantCreateRequest body=mapper.readValue(raw,PlantCreateRequest.class);
                return service.replace(id,body,audit(caller)).map(p->json(request,HttpStatus.OK,p)).orElseGet(()->json(request,HttpStatus.NOT_FOUND,Map.of("error","Plant not found")));
            }
            PlantUpdateRequest body=mapper.readValue(raw,PlantUpdateRequest.class);
            return service.patch(id,body,audit(caller)).map(p->json(request,HttpStatus.OK,p)).orElseGet(()->json(request,HttpStatus.NOT_FOUND,Map.of("error","Plant not found")));
        } catch (SecurityException ex) { return json(request,HttpStatus.UNAUTHORIZED,Map.of("error","Unauthorized"));
        } catch (IllegalArgumentException ex) { return json(request,HttpStatus.BAD_REQUEST,Map.of("error",ex.getMessage()));
        } catch (LakebaseDataApiException ex) { return upstream(request,ex);
        } catch (Exception ex) { context.getLogger().severe("Plant by-id error: "+ex.getMessage()); return json(request,HttpStatus.INTERNAL_SERVER_ERROR,Map.of("error","Unable to process plant")); }
    }

    private String audit(CallerIdentity c){ if(c.email()!=null&&!c.email().isBlank()) return c.email(); if(c.objectId()!=null&&!c.objectId().isBlank()) return c.objectId(); return "GBC_ACCESS_API"; }
    private long parseLong(String v,String n){try{return Long.parseLong(v);}catch(Exception e){throw new IllegalArgumentException(n+" must be numeric");}}
    private Long parseLongNullable(String v,String n){return v==null||v.isBlank()?null:parseLong(v,n);}
    private Boolean parseBoolean(String v){if(v==null||v.isBlank())return null;if("true".equalsIgnoreCase(v))return true;if("false".equalsIgnoreCase(v))return false;throw new IllegalArgumentException("active must be true or false");}
    private HttpResponseMessage json(HttpRequestMessage<?> r,HttpStatus s,Object b){return r.createResponseBuilder(s).header("Content-Type","application/json").body(b).build();}
    private HttpResponseMessage upstream(HttpRequestMessage<?> r, LakebaseDataApiException ex) {
        HttpStatus status = switch (ex.getStatusCode()) {
            case 400 -> HttpStatus.BAD_REQUEST;
            case 401 -> HttpStatus.UNAUTHORIZED;
            case 403 -> HttpStatus.FORBIDDEN;
            case 404 -> HttpStatus.NOT_FOUND;
            case 409 -> HttpStatus.CONFLICT;
            default -> HttpStatus.INTERNAL_SERVER_ERROR;
        };
        return json(r, status, Map.of(
                "error", "Lakebase Data API rejected the operation",
                "lakebaseStatus", ex.getStatusCode()
        ));
    }
}
