with location as (

    select
        location_iso_code as id,
        location,
        island,
        AREA_KM_2_ as area

    from "INTERVIEW_DB"."PLAYGROUND_SURIYA_BALAMURUGAN"."LOCATION"

),

cases as (

    select
        location_iso_code as id,
        date,
        total_cases,
        total_active_cases,
        new_active_cases

    from "INTERVIEW_DB"."PLAYGROUND_SURIYA_BALAMURUGAN"."COVID_INFO"

),

populate as (

    select
        id,
        min(new_active_cases) as low_cases,
        max(new_active_cases) as high_cases

    from cases
    group by 1

),


final as (

    select
        location.id,
        location.location,
        location.island,
        populate.low_cases,
        populate.high_cases

    from location
    join populate using (id)

)

select * from final
